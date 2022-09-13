require_relative 'questionsdb'
require_relative 'users'
require_relative 'replies'

class Question
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        Question.new(question.first)
    end
    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                user_id = ?
        SQL
        questions.map { |question_data| Question.new(question_data) }
    end
    def self.most_followed(n)
        QuestionFollow.most_followed_question(n)
    end
    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end
    attr_accessor :id, :title, :body, :user_id
    def initialize(attributes)
        @id = attributes[:id]
        @title = attributes[:title]
        @body = attributes[:body]
        @user_id = attributes[:user_id]
    end
    def author
        User.find_by_id(self.user_id)
    end
    def replies
        Reply.find_by_question_id(self.id)
    end
    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end
    def likers
        QuestionLike.likers_for_question_id(self.id)
    end
    def num_likes
        QuestionLike.num_likes_for_question_id(self.id)
    end
    def attrs
        { title: title, body: body, user_id: user_id }
    end
    def save
        if @id
            QuestionsDatabase.instance.execute(<<-SQL, attrs.merge({id: id}))
                UPDATE
                    questions
                SET
                    title = :title, body = :body, user_id = :user_id
                WHERE
                    id = :id
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, attrs)
                INSERT INTO
                    questions (title, body, user_id)
                VALUES
                    (:title, :body, :user_id)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        end
        self
    end
end