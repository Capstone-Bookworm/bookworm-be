class BooksFacade
  def self.get_book_objects(title)
    if title.strip.empty?
      []
    else
      books_json = GoogleBooksService.search(title)
  
      books_json.map do |book_data|
        BookPoro.new(book_data) if !book_data.nil?
      end.compact
    end
  end
end