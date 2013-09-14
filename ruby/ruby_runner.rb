require 'json'


class RubyRunner
  attr_reader :output, :exception, :result, :success_id

  def to_json
    {
        output: output,
        result: result,
        success_id: success_id,
        error: error,
        error_detail: error_detail,
        success: error.nil?
    }.to_json
  end

  def error
    @error ||= if exception
                 if exception.respond_to? :message
                   exception.message
                 else
                   exception.class.name
                 end
               end

  end

  def error_detail
    exception.to_s if exception
  end

  def execute(params)
    code = params.is_a?(Hash) ? (params[:code] || params['code']) : params
    capture_exceptions_eval(code)
    @result
  end

  def capture_exceptions_eval(code)
    begin

      require('json')
      require('date')
      require('forwardable')
      require('delegate')
      require('set')
      require('uri')
      require('timeout')
      require('benchmark')

      #module Kernel
      #  undef require
      #end

      ENV.keys.each {|key| ENV[key] = nil}

      Timeout::timeout(3) do
        @result, @output, @success_id = eval(code)
      end

      @result = nil if @result == ''
      @success_id = nil if @success_id == ''

        # normally its bad business to rescue Exception, but in this case we don't want anything in the
        # sandbox to break our program since its a program inside of a program.
    rescue Exception => exc
      @output = CW_OUTPUT || []
      @exception = exc
      @output << "<div class='is-error-text'>#{exc.message}<div>"
    end

    @output ||= []
    if @output.count > 100
      @output = @output.take(99) << @output.last
      @output << 'output truncated'
    end
  end
end