class BooksFacade
  def self.get_book_objects(title)
    books_json = GoogleBooksService.search(title)
    
    books_json[:items].map do |book_data|
      BookPoro.new(book_data)
    end
  end
end