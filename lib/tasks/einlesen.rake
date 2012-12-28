#-*- encoding: utf-8 -*-
require 'iconv' #unless String.method_defined?(:encode)

desc "Einlesen von Fragen"
task :einlesen => :environment do
	script_path = Rails.root.to_s + "/lib/tasks/"
	path = script_path + ARGV[1]
	puts path
	fail "specify filename to create" unless path
	file = File.open(path, "r")

  ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')

	umlaute = ["ä","ü",'ö','Ä','Ü','Ö','ß']
	ersetzen = ['ae','ue','oe','Ae','Ue','Oe','ss']
	users = []
	groups = []
	question = nil
	#User und Gruppen in ein Array
	file.each do |line|
		ic.iconv(line)
		for i in 0..6 do 
		  line.gsub!(/#{umlaute[i]}/,ersetzen[i])
		end
		puts line
		unless line[1] == '#'
			zeile = line.split(';')
			if zeile[0] == '@'
				question = Question.create(text: zeile[2],category_id: zeile[1],status: true)
			else
				begin
				Answer.create(text:	zeile[1], question_id: question.id, points: zeile[0])
				rescue
					puts "FEHLER"
				end
			end
		end
	end
end