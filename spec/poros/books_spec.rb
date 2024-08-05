require "rails_helper"

RSpec.describe Book do
  it "can initialize with book attributes", :vcr do
    json = LibraryService.books_by_search_and_limit("denver,co","5")
    book_data = json[:docs].first
    book = Book.new(book_data)

    expect(book).to be_a Book
    expect(book.isbn).to be_a Array
    expect(book.title).to be_a String
    expect(book.publisher).to be_a Array
  end
end