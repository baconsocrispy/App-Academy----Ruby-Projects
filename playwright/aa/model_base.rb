require 'active_support/inflector'
require_relative 'questions_database'

class ModelBase
    def self.table
        self.to_s.tableize
    end
    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
            SELECT
                *
            FROM
                #{table}
            WHERE
                id = :id
        SQL
        data.nil? ? nil : self.new(data.first)
    end
    def self.all
        data = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                #{table}
        SQL
        parse_all(data)
    end
    def self.where(options_hash)
       if options_hash.is_a?(Hash)
          where_line = options_hash.keys.map { |key| "#{key} = ?" }.join(" AND ")
          vals = options_hash.values
       else
          where_line = options_hash
          vals = []
       end

       data = QuestionsDatabase.instance.execute(<<-SQL, *vals)
        SELECT
          *
        FROM
          #{table}
        WHERE
          "#{where_line}"
        SQL
        parse_all(data)
    end
    def self.find_by(options)
      self.where(options)
    end
    def save

    end
    def self.parse_all(data)
        data.map { |attrs| self.new(attrs) }
    end
end