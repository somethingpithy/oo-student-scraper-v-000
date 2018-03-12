require 'open-uri'
require 'pry'
require 'Nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open("index_url"))
    students = []
    index.css("div.roster-cards-container").each { |card|
      card.css(".student-card").each { |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open("profile_url"))
    profile.css("") { ||
      }
    # scrapes students's profile page and returns a hash of attributes describing an individual student.
    # Attributes to scrape include :twitter, :linkedin, :github, :blog, :profile_quote, and :bio
  end

end
