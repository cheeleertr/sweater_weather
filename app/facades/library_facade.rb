class LibraryFacade
  def initialize

  end

  def books_by_search_and_limit(search, limit)
    books = LibraryService.books_by_search_and_limit(search, limit)
    {
      total_books_found: books[:numFound],
      books: books[:docs].map { |book| Book.new(book) }
    }
  end
end