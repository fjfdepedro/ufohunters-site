module ApplicationHelper

   def format_date date
      unless date.blank?
         date.to_date.strftime("%A %d. %B %Y")
      end
   end

   def youtube_link?(link)
   	link =~ /(youtube|youtu.be)/
   end

   def youtube_video(url)
      video_id = youtube_video_id(url)
      render :partial => 'common/video', :locals => {:video_id => video_id} unless video_id.blank?
   end

   def youtube_video_id(url)
      begin
         uri = URI.parse(url)
         video_id = nil
         unless uri.query.blank?
            query_string = CGI.parse(uri.query)
            # v is the param in the query string having the video id when the host is youtube.com
            v = query_string['v']
            video_id = v[0] unless v.blank?
         else
            # when the host is youtu.be the video id is the path without the starting slash
            video_id = uri.path
            video_id = video_id[1..-1]
         end
         
      rescue => ex
         logger.info "Invalid uri - #{ex.class}: #{ex.message}"
         return nil
      end
   end

   

end
