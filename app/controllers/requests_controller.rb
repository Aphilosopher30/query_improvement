class RequestsController < ApplicationController
  require 'http'

  def input
  end 


  def ask
    question = params[:question]
    response = chat_with_gpt(question)
    render json: { question: question, answer: response }
  end

  private

  #Future Task: abstract out the api call
  def chat_with_gpt(question)

    api_key = ENV['gpt_key']
    response = HTTP.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      },
      json: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question }]
      }
    )

    json_response = response.parse
    json_response.dig("choices", 0, "message", "content") || "No response"
  end
end
