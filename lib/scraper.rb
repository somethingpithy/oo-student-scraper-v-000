require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open("index_url"))
    students = []
    index.css("div.roster-cards-container").each { |card|
      card.css(".student-card a").each { |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open("profile_url"))
    links = profile.css("div.social-icon-container").children.css("a").map { |link| link.attribute('href').value }
    links.each do { |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else link.include?("blog")
        student[:blog] = link
      end
    }
    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
  end

end
