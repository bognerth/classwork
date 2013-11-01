#-*- encoding: utf-8 -*-
require 'iconv' #unless String.method_defined?(:encode)

desc "Einlesen von Schuelern"
#FIT1AF;Beßler;Stefan;02.10.1984
#Aufruf Console: rake einlesen_schueler['dateiname']
#Aufruf seeds: Rake::Task[:einlesen_schueler].invoke('schueler-2013.txt')
task :einlesen_schueler, [:datei] => [:environment] do |t, args|
  script_path = Rails.root.to_s + "/lib/tasks/"
  path = script_path + args.datei
  puts path
  fail "specify filename to create" unless path
  file = File.open(path, "r")

  ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')

  umlaute = ["ä","ü",'ö','Ä','Ü','Ö','ß']
  ersetzen = ['ae','ue','oe','Ae','Ue','Oe','ss']

  #User und Gruppen in ein Array
  file.each do |line|
    ic.iconv(line)
    for i in 0..6 do 
      line.gsub!(/#{umlaute[i]}/,ersetzen[i])
    end
    
    zeile = line.split(';')
    
    if zeile
      puts line
      begin
        group = Group.where(name: zeile[0]).first_or_create
        user = User.create(:email => "#{zeile[2]}.#{zeile[1]}@g16-hh.de", :password => zeile[3], :password_confirmation => zeile[3])
        student = Student.create(user_id: user.id, group_id: group.id)
      rescue Exception => e
        puts "FEHLER: " << e.to_s
      end
    end
  end
end