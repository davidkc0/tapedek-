module UrlHelp

  def self.cut_before_domain(url)
    if url.start_with?("http") 
      url = url.split("://")[1]
    end
    if url.start_with?("www.")
      url = url.split("www.")[1]
    end
    url
  end

  def self.is_gif?(video_url)
    video_url.split(".")[-1] == "gif"
  end

  def embed_token
    case provider
    when "youtube"
      regex = /youtube.com.*(?:\/|v=)([^&$]+)/
      return video_url.match(regex)[1] if video_url.present? and video_url.match(regex).present?
    when "vimeo"
      regex = /vimeo.com.*(?:\/|v=)([^&$]+)/
      return video_url.match(regex)[1] if video_url.present? and video_url.match(regex).present?
    when "vine"
      regex = /vine.co.*(?:\/|v=)([^&$]+)/
      return video_url.match(regex)[1] if video_url.present? and video_url.match(regex).present?
    when "instagram"
      regex = /instagram.com.*(?:\/|v=)([^&$]+)/
      url = video_url.split("?")[0]
      return url.match(regex)[1] if url.present? and url.match(regex).present?
    else
      ## No idea
    end
  end

end