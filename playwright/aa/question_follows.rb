require_relative 'questionsdb'
require_relative 'users'

class QuestionFollow
    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        QuestionFollow.new(question_follow.first)
    end
    def self.followers_for_question_id(question_id)
        followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_follows 
            ON 
                users.id = question_follows.user_id
            WHERE
                question_follows.question_id = ?
        SQL
        followers.map { |user_data| User.new(user_data) } 
    end
    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows 
            ON 
                question_follows.user_id = questions.user_id
            WHERE
                question_follows.user_id = ?
        SQL
        questions.map { |question_data| Question.new(question_data) }
    end
    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows
            ON
                questions.id = question_follows.question_id
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

