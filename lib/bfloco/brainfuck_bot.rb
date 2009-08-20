class BrainfuckBot
  attr_accessor :last_tweet
  
  def initialize
    @last_tweet = begin
      tweets = []
      Twitter::Search.new('brainfuck').each do |r| 
        tweets << r[:id]
      end rescue nil
      tweets.first
    end
  end
  
  def annoy_people    
    while true
      Thread.new { annoy_them_now }
      sleep 120
    end
  end
    
  private
  
    def annoy_them_now
      tweets = []
      search = Twitter::Search.new('brainfuck')
      search.since(last_tweet)
      puts "Polling #{Time.now}"
      search.each do |r|
        tweets << r[:id]
        unless r[:from_user] == "brainfuck_loco"
          message = "@#{r[:from_user]} #{BrainfuckConverter.convert(r[:text])}<"
          Net::HTTP.post_form(self.class.base_uri, { 'status' => message, 'in_reply_to_status_id' => r[:id] }) rescue nil
          BrainfuckLoco::logger.info message
        end
      end rescue nil
      self.last_tweet = tweets.first if tweets.first
    end
  
    def self.base_uri
      @@base_uri ||= URI.parse( "http://#{ BrainfuckLoco::logger.config[:username]}:#{BrainfuckLoco::logger.config[:password]}@twitter.com/statuses/update.json" )
    end
end