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

  def self.clean_url(url, domain)
    case domain
    when "youtube"
      regex = /(\?v=)[A-Za-z0-9_-]+/
      uniq_id = url.match(regex) ? url.match(regex)[0] : nil
      uniq_id ? "youtube.com/watch#{uniq_id}" : nil
    when "vimeo"
      regex = /vimeo.com\/[0-9]+/
      uniq_id = url.match(regex) ? url.match(regex)[0] : nil
    when "vine"
      regex = /vine.co\/v\/[a-zA-Z0-9]+/
      uniq_id = url.match(regex) ? url.match(regex)[0] : nil
    when "instagram"
      regex = /instagram.com\/p\/[a-zA-Z0-9_-]+/
      uniq_id = url.match(regex) ? url.match(regex)[0] : nil
    when "twitch"
      regex = /twitch.tv\/[a-zA-Z0-9_-]+\/v\/[a-zA-Z0-9_-]+/
      uniq_id = url.match(regex) ? url.match(regex)[0] : nil
    when "gif"
      return url
    else
      return nil
    end
  end

  def embed_token
    case provider
    when "youtube"
      regex = /(?<=youtube.com\/watch\?v=)[\w+-]+/
      return video_url.match(regex)[0] if video_url.present? and video_url.match(regex).present?
    when "vimeo"
      regex = /(?<=vimeo.com\/)[\w+-]+/
      return video_url.match(regex)[0] if video_url.present? and video_url.match(regex).present?
    when "vine"
      regex = /(?<=vine.co\/v\/)[\w+-]+/
      return video_url.match(regex)[0] if video_url.present? and video_url.match(regex).present?
    when "instagram"
      regex = /(?<=instagram.com\/p\/)[\w+-]+/
      return video_url.match(regex)[0] if video_url.present? and video_url.match(regex).present?
    when "twitch"
      regex = /(?<=twitch.tv\/)[\w+-]+\/v\/[\w+-]+/
      return video_url.match(regex)[0] if video_url.present? and video_url.match(regex).present?
    else
      ## No idea
    end
  end

end