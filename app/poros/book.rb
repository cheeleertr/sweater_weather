class Book
  attr_reader :isbn, :title, :publisher

  def initialize(data)
    # binding.pry
    # @total_books_found
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
  end
end