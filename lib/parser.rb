module Parser

  attr_reader :mail

  # takes a mail and returns an array of post array
  def parse(mail)
    @mail = mail
    post = []
    body = ""
    if !mail.body.parts.empty?
      get_textual_body_io.each_line do |line|
        if line.match(/^\s*\/\/ /)
          post << line.gsub(/^\s*\/\/ /, "").chomp if post.length == 0
          post << mail.date.to_date if post.length == 1
          post << body if post.length == 2 && body.length > 0
          if post.length == 3
            yield post
            post = []
            body = ""
            post << line.gsub(/^\s*\/\/ /, "").chomp
          end
        else
          body << line.gsub(/\n/, "")
        end
      end # end each_line
      post << body
      yield post if post.length == 3
    end # end if
  end

private

  def get_textual_body_io
    body = Helper.force_encoding(mail.body.parts.first.body.to_s)
    StringIO.new(body.split("Create an Account: \nhttps://www.feedmyinbox.com/")[0])
  end

end