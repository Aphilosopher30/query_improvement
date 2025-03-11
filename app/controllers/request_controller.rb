class RequestController < ApplicationController
  require 'http'

  def ask
    question = params[:question] #{}"tell me in one sentence what a good." #params[:question]
    response = chat_with_gpt(question)
    render json: { question: question, answer: response }
  end

  private

  def chat_with_gpt(question)
    # binding.pry
    api_key = ENV['gpt_key']
    response = HTTP.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      },
      json: {
        model: "o1-mini",
        messages: [{ role: "user", content: question }]
      }
    )

    puts "Response status: #{response.status}"
    puts "Response body: #{response.body}"


    json_response = response.parse
    json_response.dig("choices", 0, "message", "content") || "No response"
  end
end
