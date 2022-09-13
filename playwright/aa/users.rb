require_relative 'model_base'
require_relative 'questionsdb'
require_relative 'questions'
require_relative 'replies'

class User < ModelBase
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        User.new(user.first)
    end
    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname,lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
                AND lname = ?
            SQL
        return nil unless user.length > 0
        User.new(user.first)
    end

    attr_accessor :id, :fname, :lname
    def initialize(attributes)
        @id = attributes[:id]
        @fname = attributes[:fname]
        @lname = attributes[:lname]
    end
    def authored_questions
        Question.find_by_author_id(self.id)
    end
    def authored_replies
        Reply.find_by_user_id(self.id)
    end
    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end
    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end
    def average_karma
        QuestionsDatabase.instance.execute(<<-SQL, self.id)
            SELECT
                CAST(COUNT(question_likes.id) AS FLOAT) / 
                COUNT(DISTINCT questions.id) AS avg_karma
            FROM 
                questions
            LEFT OUTER JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                questions.user_id = ?
        SQL
    end
    def attrs
        { fname: fname, lname: lname }
    end
    def save
        if @id
            QuestionsDatabase.instance.execute(<<-SQL, attrs.merge({id: id}))
                UPDATE
                    users
                SET
                    fname = :fname, lname = :lname
                WHERE
                    users.id = :id
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, attrs)
                INSERT INTO
                    users (fname, lname)
                VALUES
                    (:fname, :lname)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        end
        self
    end       
end

