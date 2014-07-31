class Payment < ActiveRecord::Base
  attr_accessible  :line_item_id, :service_id

  belongs_to :service
  
  def self.with(query)
   # in query we have hash value of  :line_item_id, :service_id
   query.assert_valid_keys(:line_item_id, :service_id)
        # its Validate all keys in a query 
	# first create payment if it does not exist
   transaction(isolation: :serializable) do                  
      # its use for locks on data or implements multiversion concurrency control
     connection.execute <<-SQL
	INSERT INTO payments (line_item_id, service_id)
	SELECT #{sanitize query[:line_item_id]}, #{sanitize query[:service_id]}
	WHERE NOT EXISTS (
	SELECT line_item_id FROM payments
	WHERE #{sanitize_sql_hash_for_conditions query}
	)
      SQL
   end
	# now we can lock a single record and execute arbitrary code on it
   yield where(query).lock(true).first!
	# prevent method from accidental returning unsynchronized payment
   nil
 end
end
