module Mina
  module Hooks
    module Plugin

      def before_mina_tasks
        @before_mina_tasks ||= []
      end

      def after_mina_tasks
        @after_mina_tasks ||= []
      end

      def before_mina(*tasks)
        @before_mina_tasks = self.before_mina_tasks + tasks
      end

      def after_mina(*tasks)
        @after_mina_tasks = self.after_mina_tasks + tasks
      end

      def invoke_before_mina_tasks
        return unless deploying?

        print_local_status "Invoke before mina tasks"
        print_task_list self.before_mina_tasks if self.verbose_mode?

        self.before_mina_tasks.each { |task_name| self.invoke task_name }
      end

      def invoke_after_mina_tasks
        return unless deploying?

        print_local_status "Invoke after mina tasks"
        print_task_list self.after_mina_tasks if self.verbose_mode?

        self.after_mina_tasks.each { |task_name| self.invoke task_name }
      end

      def mina_cleanup!
        self.invoke_before_mina_tasks
        super if defined?(super)
        self.invoke_after_mina_tasks
      end

      def print_task_list(tasks)
        task_list = "tasks: #{tasks.join(", ")}"
        puts "       #{color(">>", 32)} #{color(task_list, 32)}"
      end

      # Prints a status message. (`<-----`)
      def print_local_status(msg)
        puts ""  if verbose_mode?
        puts "#{color('<-----', 32)} #{msg}"
      end

      def deploying?
        @deploying ||= ARGV.include? "deploy"
      end
    end
  end
end
