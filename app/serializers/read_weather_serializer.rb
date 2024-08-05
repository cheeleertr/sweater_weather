class ReadWeatherSerializer
  include JSONAPI::Serializer

  def self.format_read_weather(destination, forecast, books)
    {
    data: {
      id: nil,
      type: "books",
      attributes: {
        destination: destination,
        forecast: {
          summary: forecast.current_weather.condition,
          temperature: "#{forecast.current_weather.temperature.to_i} F",
          },
        total_books_found: books[:total_books_found],
        books: format_books(books[:books])
        }
      }
    }
  end

  def self.format_books(books)
    books.map do |book|
      
        {
          isbn: book.isbn,
          title: book.title,
          publisher: book.publisher
        }
      
    end
  end
end