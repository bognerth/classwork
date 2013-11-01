#-*- encoding: utf-8 -*-
require 'iconv' #unless String.method_defined?(:encode)

desc "Einlesen von Fragen"
task :einlesen_fragen, [:datei, :cat] => [:environment] do |t, args|
	script_path = Rails.root.to_s + "/lib/tasks/"
	path = script_path + args.datei
	puts path
	fail "specify filename to create" unless path
	file = File.open(path, "r")

	#course anlegen
	cat_title = args.cat || ("Category-" + Date.today.to_s)
	puts cat_title
	category = Category.where(:name => "#{cat_title}").first_or_create

	ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')

	umlaute = ["ä","ü",'ö','Ä','Ü','Ö','ß','\'']
	ersetzen = ['ae','ue','oe','Ae','Ue','Oe','ss', ' ']

	question = nil

	file.each do |line|
		ic.iconv(line)
		for i in 0..7 do 
		  line.gsub!(/#{umlaute[i]}/,ersetzen[i])
		end
		puts line
		begin
			unless line[0] == '#'
				zeile = line.split(';')
				if zeile[0] == '@'
					question = Question.create(text: zeile[2], category_id: category.id, status: true)
				else
					Answer.create(text:	zeile[1], question_id: question.id, points: zeile[0])
				end
			end
		rescue	Exception => e
     	puts "FEHLER: " << e.to_s << line
		end
	end
end