require 'rails_helper'

RSpec.describe BookPoro do
  describe 'initialize' do
    it 'has readable attributes' do
      book_details = {
          title: "The Moon Is a Harsh Mistress",
          author:
              "Robert A. Heinlein",
          summary: "For fans of Artemis—the visionary tour de force from “one of the grand masters of science fiction” (The Wall Street Journal). Widely acknowledged as one of Robert A. Heinlein's greatest works, The Moon Is a Harsh Mistress rose from the golden age of science fiction to become an undisputed classic—and a touchstone for the philosophy of personal responsibility and political freedom. A revolution on a lunar penal colony—aided by a self-aware supercomputer—provides the framework for a story of a diverse group of men and women grappling with the ever-changing definitions of humanity, technology, and free will—themes that resonate just as strongly today as they did when the novel was first published. The Moon Is a Harsh Mistress gives readers an extraordinary, thought-provoking glimpse into the mind of Robert A. Heinlein, who, even now, “shows us where the future is” (Tom Clancy).",
          isbn: "9780440001355",
          page_count: 402,
          image_url: "http://books.google.com/books/content?id=cMZiDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
          }
          
      book = BookPoro.new(book_details)

      expect(book.title).to eq(book_details[:title])
      expect(book.author).to eq(book_details[:author])
      expect(book.isbn).to eq(book_details[:isbn])
      expect(book.page_count).to eq(book_details[:page_count])
      expect(book.summary).to eq(book_details[:summary])
      expect(book.image_url).to eq(book_details[:image_url])
    end
  end
end