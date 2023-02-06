class BooksFacade
  def self.get_book_objects(title, author)
    books_json = GoogleBooksService.search(title, author)
    
    books_json[:items].map do |book_data|
      BookPoro.new(book_data)
    end
  end
end