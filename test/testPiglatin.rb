#Testing the class: Piglatin
require '../piglatinClass'

RSpec.describe "Piglatin" do

	describe "instance" do
		it "should create a Piglatin object" do
			piglatin = Piglatin.new("")
			expect(piglatin).to be_an_instance_of(Piglatin)
		end
	end

	describe "sentence" do
		sentence =  "Hello my friends"
		piglatin = Piglatin.new(sentence)
		it "should be reset without reinitializing" do
			piglatin.sentence = "Hello folks"
			expect(piglatin.phrase).to eq("Hello folks")
		end

		it "should be private" do 
			expect {piglatin.sentence}.to raise_error(NoMethodError)
		end
	end

	describe "object" do
		describe "method 'phrase'" do
			sentence =  "Hello my friends"
			piglatin = Piglatin.new(sentence)

			it "should exists" do
				expect(piglatin).to respond_to(:phrase)
			end

			it "should return the sentence" do
				expect(piglatin.phrase).to eq("Hello my friends")
			end
		end

		describe "method 'translateWord'" do
			sentence =  "Hello my friends"
			piglatin = Piglatin.new(sentence)

			it "should exists" do
				expect {piglatin.send(:translateWord)}.not_to raise_error(NoMethodError)
			end

			it "should receive an english word and return it in pig latin" do
				expect(piglatin.send(:translateWord,"Hello")).to eq("Ellohay")
				expect(piglatin.send(:translateWord,"Well")). to eq("Ellway")
				expect(piglatin.send(:translateWord,"think")).to eq("inkthay")
				expect(piglatin.send(:translateWord,"welcome")).to eq("elcomeway")
				expect(piglatin.send(:translateWord,"known")).to eq("ownknay")
				expect(piglatin.send(:translateWord,"enough")).to eq("enoughay")
				expect(piglatin.send(:translateWord,"any")).to eq("anynay")
				expect(piglatin.send(:translateWord,"special")).to eq("ecialspay")
			end
		end

		describe "method 'createDictionary'" do
			sentence =  "Hello my friends this is my new: car!"
			piglatin = Piglatin.new(sentence)

			it "should exists" do
				expect {piglatin.send(:createDictionary)}.not_to raise_error(NoMethodError) 
			end

			it "should return a hash with the english words contained in the sentence and their translations" do
				
				expect(piglatin.send(:createDictionary)).to include(
					"Hello" => "Ellohay",
					"my" => "myay",
					"friends" => "iendsfray",
					"this" => "isthay",
					"is" => "isay",
					"new" => "ewnay",
					"car" => "arcay"
				)

				piglatin.sentence = "What do you think when you hear 'well-being'?"

				expect(piglatin.send(:createDictionary)).to include(
					"What" => "Atwhay",
					"do" => "oday",
					"you" => "ouyay",
					"think" => "inkthay",
					"when" => "enwhay",
					"hear" => "earhay",
					"well" => "ellway",
					"being" => "eingbay"
				)

				piglatin.sentence = "I love analyze any problems"

				expect(piglatin.send(:createDictionary)).to include(
					"I" => "Iyay",
					"love" => "ovelay",
					"analyze" => "analyzeyay",
					"any" => "anynay",
					"problems" => "oblemspray"
				)

			end
		end

		describe "method 'translate'" do
			sentence =  ""
			piglatin = Piglatin.new(sentence)

			it "should exists" do
				expect(piglatin).to respond_to(:translate)
			end

			it "should return the sentence translated to piglatin" do
				expect(piglatin.translate()).to eq(nil)
				
				piglatin.sentence = "Hello my friends this is my new: car!"
				expect(piglatin.translate()).to eq("Ellohay myay iendsfray isthay isay myay ewnay: arcay!")
				
				piglatin.sentence =  "What do you think when you hear 'well-being'?"
				expect(piglatin.translate()).to eq("Atwhay oday ouyay inkthay enwhay ouyay earhay 'ellway-eingbay'?")
				
				piglatin.sentence =  "I love analyze any problems"
				expect(piglatin.translate()).to eq("Iyay ovelay analyzeyay anynay oblemspray")

				piglatin.sentence = "I've missed more than 9000 shots in my career. I've lost almost 300 games. 26 times, I've been trusted to take the game winning shot and missed. I've failed over and over and over again in my life!. And that is why I succeed."
				expect(piglatin.translate()).to eq("Iyay'evay issedmay oremay anthay 9000 otsshay inay myay areercay. Iyay'evay ostlay almostay 300 amesgay. 26 imestay, Iyay'evay eenbay ustedtray otay aketay ethay amegay inningway otshay anday issedmay. Iyay'evay ailedfay overay anday overay anday overay againay inay myay ifelay!. Anday atthay isay whyay Iyay ucceedsay.")
			end
		end
	end
end