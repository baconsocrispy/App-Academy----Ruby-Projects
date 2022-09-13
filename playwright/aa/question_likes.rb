require_relative 'questionsdb'

class QuestionLike
    def self.find_by_id(id)
        like = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        QuestionLike.new(like.first)
    end
    def self.likers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_likes
            ON
                users.id = question_likes.user_id
            WHERE
                question_likes.question_id = ?
        SQL
        users.map { |user_data| User.new(user_data) }
    end
    def self.num_likes_for_question_id(question_id)
        likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                COUNT(*) AS likes
            FROM
                questions
            JOIN
                question_likes
            ON
                question_likes.question_id = questions.id
            WHERE
                questions.id = ?
        SQL
    end
    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                questions
            JOIN
                question_likes
            ON
                question_likes.question_id = questions.id
            WHERE
                question_likes.user_id = ?
        SQL
        questions.map { |question_data| Question.new(question_data) }
    end
    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            GROUP BY
                questions.id
            ORDER BY
                COUNT(*)
            LIMIT
                ?
        SQL
        questions.map { |question_data| Question.new(question_data) }
    end
    attr_accessor :id, :user_id, :question_id
    def initialize(attributes)
        @id = attributes['id']
        @user_id = attributes['user_id']
        @question_id = attributes['question_id']
    end
end

