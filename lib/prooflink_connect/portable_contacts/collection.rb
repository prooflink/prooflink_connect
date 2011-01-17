class Collection < Array
  attr_reader :total_entries, :per_page, :start_index

  def initialize(data)
    super data["entry"].collect{|e| PortableContacts::Person.new(e) }
    @total_entries=data["totalResults"].to_i
    @per_page=data["itemsPerPage"].to_i
    @start_index=data["startIndex"].to_i
  end
end