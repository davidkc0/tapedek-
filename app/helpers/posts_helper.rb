module PostsHelper

  def embedded_video(post)
    case post.provider
    # YOUTUBE #
    when "youtube"
      return "<div class='embed-responsive embed-responsive-16by9'>\
              <iframe class='embed-responsive-item' src='https://www.youtube.com/embed/#{post.embed_token}' allowFullScreen='true'>\
              </iframe></div>".html_safe
    # VIMEO #
    when "vimeo"
      return "<div class='embed-responsive embed-responsive-16by9'>\
            <iframe src='//player.vimeo.com/video/#{post.embed_token}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen>\
            </iframe></div>".html_safe
    # VINE #
    when "vine"
      return "<div class='embed-responsive embed-responsive-16by9'>\
              <iframe class='vine-embed' src='https://vine.co/v/#{post.embed_token}/embed/simple' width='600' height='600' frameborder='0'>\
              </iframe></div>".html_safe
    # INSTAGRAM #
    when "instagram"
      return "<div class='insta_embed'><iframe src='//instagram.com/p/#{post.embed_token}/embed/' width='612' height='710' frameborder='0' scrolling='no' allowtransparency='true'></iframe></div>".html_safe
      
      # return "<div class='insta_embed'><iframe class='instagram-media instagram-media-rendered' id='instagram-embed-0' src='//instagram.com/p/#{post.embed_token}/embed/captioned/?v=4' height='400'></iframe></div>".html_safe
      # return "<div id='#{post.embed_token}' class='insta_embed'><script>insta_embed('#{post.embed_token}')</script></div>".html_safe
    when "twitch"
      channel = post.embed_token.split("/v/")[0]
      id = post.embed_token.split("/v/")[1]
      return "<div class='embed-responsive embed-responsive-16by9'>\
              <object data='//www.twitch.tv/swflibs/TwitchPlayer.swf' class='clip_embed_player_flash' type='application/x-shockwave-flash'>\
              <param name='movie' value='//www.twitch.tv/swflibs/TwitchPlayer.swf' />\
              <param name='allowScriptAccess' value='always' />\
              <param name='allowNetworking' value='all' />\
              <param name='allowFullScreen' value='true' />\
              <param name='flashvars' value='channel=#{channel}&amp;auto_play=false&amp;start_volume=25&amp;videoId=v#{id}&amp;auto_play=false&amp;eventsCallback=onPlayerEvent' />\
              </object>\
              </div>".html_safe
    when "gif"
      return "<div class='embed-responsive embed-responsive-16by9'>\
              <div class='gif_img'><img src='#{post.video_url}'></div>\
              </div>".html_safe
      # return "<blockquote class='imgur-embed-pub' lang='en' data-id='#{post.video_url.split('.com')[1]}'><a href='#{post.video_url.split('.gif')[0]}'>View post on imgur.com</a></blockquote><script async src='//s.imgur.com/min/embed.js' charset='utf-8'></script>".html_safe
    else
      return "Error"
    end    
          #<div class="embed-responsive embed-responsive-16by9">
          #
  end
end
