class LibraryService
  def self.conn
    Faraday.new(url: "https://openlibrary.org")
  end

  def self.books_by_search_and_limit(search, limit)
    response = conn.get("search.json?q=#{search}&limit=#{limit}")
    # binding.pry
    JSON.parse(response.body, symbolize_names: true)
  end
end