module PostsHelper

  def embedded_video(post)
    case post.provider
    when "youtube"
      return "<div class='embed-responsive embed-responsive-16by9'>\
              <iframe class='embed-responsive-item' src='https://www.youtube.com/embed/#{post.embed_token}' allowFullScreen='true'>\
              </iframe></div>".html_safe
    when "vimeo"
      return "<div class='embed-responsive embed-responsive-16by9'>\
            <iframe src='//player.vimeo.com/video/#{post.embed_token}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen>\
            </iframe></div>".html_safe
    when "vine"
      return "vine"
    when "instagram"
      return "instagram"
    when "twitch"
      return "twitch"
    when "gif"
      return "gif"  
    else
      return "Error"
    end    
          ##<div class="embed-responsive embed-responsive-16by9">
          ##
  end
end
