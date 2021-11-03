module TextSearchable

  extend ActiveSupport::Concern

  # Define common scopes for shop order assignable objects.
  included do
    scope :with_text_containing, ->(field, value, options = {}) {
      return if value.blank?
      join_table = options.fetch :join_table, nil
      conditions = []
      re = /'.*?'|".*?"|\S+/
      value.scan(re) do |individual_term|
        unquoted_term = individual_term
        unquoted_term = individual_term.delete_prefix("'").delete_suffix("'") if individual_term[0] == "'" && individual_term[-1] == "'"
        unquoted_term = individual_term.delete_prefix("\"").delete_suffix("\"") if individual_term[0] == "\"" && individual_term[-1] == "\""
        conditions << "#{field} LIKE (\"%#{unquoted_term}%\")"
      end
      if join_table.nil?
        where(conditions.join(" AND "))
      else
        left_outer_joins(join_table).where(conditions.join(" AND "))
      end
    }
  end

end