require 'rails_helper'

RSpec.describe BookPoro do
  describe 'initialize' do
    it 'has readable attributes' do
      book_details = {
        volumeInfo: {
          title: "The Moon Is a Harsh Mistress",
          authors: [
              "Robert A. Heinlein"
          ],
          description: "For fans of Artemis—the visionary tour de force from “one of the grand masters of science fiction” (The Wall Street Journal). Widely acknowledged as one of Robert A. Heinlein's greatest works, The Moon Is a Harsh Mistress rose from the golden age of science fiction to become an undisputed classic—and a touchstone for the philosophy of personal responsibility and political freedom. A revolution on a lunar penal colony—aided by a self-aware supercomputer—provides the framework for a story of a diverse group of men and women grappling with the ever-changing definitions of humanity, technology, and free will—themes that resonate just as strongly today as they did when the novel was first published. The Moon Is a Harsh Mistress gives readers an extraordinary, thought-provoking glimpse into the mind of Robert A. Heinlein, who, even now, “shows us where the future is” (Tom Clancy).",
          industryIdentifiers: [
              {
                  type: "ISBN_13",
                  identifier: "9780440001355"
              },
              {
                  type: "ISBN_10",
                  identifier: "0440001358"
              }
          ],
          pageCount: 402,
          imageLinks: {
              smallThumbnail: "http://books.google.com/books/content?id=cMZiDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
              thumbnail: "http://books.google.com/books/content?id=cMZiDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
          }
        }
      }
      book = BookPoro.new(book_details)

      expect(book.title).to eq(book_details[:volumeInfo][:title])
      expect(book.author).to eq(book_details[:volumeInfo][:authors][0])
      expect(book.isbn).to eq(book_details[:volumeInfo][:industryIdentifiers][0][:identifier])
      expect(book.page_count).to eq(book_details[:volumeInfo][:pageCount])
      expect(book.summary).to eq(book_details[:volumeInfo][:description])
      expect(book.image_url).to eq(book_details[:volumeInfo][:imageLinks][:thumbnail])
    end
  end
end