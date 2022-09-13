require_relative 'questionsdb'
require_relative 'users'
require_relative 'questions'

class Reply
    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        Reply.new(reply.first)
    end
    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        replies.map { |reply_data| Reply.new(reply_data) }
    end
    def self.find_by_parent_reply_id(parent_reply_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_reply_id = ?
        SQL
        replies.map { |reply_data| Reply.new(reply_data) }
    end
    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        replies.map { |reply_data| Reply.new(reply_data) }
    end
    attr_accessor :id, :parent_reply_id, :question_id, :user_id, :body
    def initialize(attributes)
        @id = attributes[:id]
        @parent_reply_id = attributes[:parent_reply_id]
        @question_id = attributes[:question_id]
        @user_id = attributes[:user_id]
        @body = attributes[:body]
    end
    def author
        User.find_by_id(self.user_id)
    end
    def question
        Reply.find_by_question_id(self.question_id)
    end
    def parent_reply
        raise 'No parent: This Is The Top Reply!' unless self.parent_reply_id
        Reply.find_by_id(self.parent_reply_id)
    end
    def child_replies
        Reply.find_by_parent_reply_id(self.id)
    end
    def attrs
        { parent_reply_id: parent_reply_id, question_id: question_id, user_id: user_id, body: body }
    end
    def save
        if @id 
            QuestionsDatabase.instance.execute(<<-SQL, attrs.merge({id: id}))
                UPDATE
                    replies
                SET
                    parent_reply_id = :parent_reply_id, question_id = :question_id, user_id = :user_id, body = :body
                WHERE
                    id = :id
            SQL
        else 
            QuestionsDatabase.instance.execute(<<-SQL, attrs)
                INSERT INTO
                    replies (parent_reply_id, question_id, user_id, body)
                VALUES
                    (:parent_reply_id, :question_id, :user_id, :body)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        end
        self
    end
end
