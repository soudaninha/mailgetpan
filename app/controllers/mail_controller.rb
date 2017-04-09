require 'mailgun'

class MailController < ApplicationController

    def home
        
    end
    
    def sending
        
        @title = params[:title]
        @email = params[:email]
        @content = params[:content]
        
        mg_client = Mailgun::Client.new("key-d0623db39ca634a921eba16f8eaedb62")

        message_params =    {
                            from:'lmvicky@likelion.org',
                            to: @email,
                            subject: @title,
                            text: @content
                            }
        
        result = mg_client.send_message('sandbox2d4e7645ed774565af178750424eead5.mailgun.org', message_params).to_h!
        
        message_id = result['id']
        message = result['message']
        
        new_post = Post.new # 노란색 post는 우리가 만든 model post랑 같은 애
        # 새롭게 생성
        new_post.title = @title
        new_post.email = @email
        new_post.content = @content
        # home를 통해서 받은 애들을 db로
        new_post.save # 받을 거야
        
        redirect_to "/list"
        # sending 왔을 때 바로 list로 넘어가는게 redirect_to
        
    end
    
    def list
        @mailing = Post.all # db의 모든 애들을 저장
    end
end
