(clear)
(open "./results.txt" file "w")

(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)
(load-package FuzzyFunctions)
(batch fakty.clp)

(watch facts)
(watch rules)

(defglobal ?*OpadFvar* = (new FuzzyVariable "opad" 0.0 100.0 "intensywnosc (%)"))
(defglobal ?*PredkoscFvar* = (new FuzzyVariable "predkosc" 0.0 250.0 "KM/H"))
(defglobal ?*WycieraczkiFvar* = (new FuzzyVariable "wycieraczki" 0.0 10.0 "intensywnosc pracy"))

(defglobal ?*tempus* = 0)

(defrule init 
 (declare (salience 100))
=>
 (import nrc.fuzzy.*)
 (load-package nrc.fuzzy.jess.FuzzyFunctions)

(bind ?rlf (new RightLinearFunction)) (bind ?llf (new LeftLinearFunction))
    
	
;;opad
(?*OpadFvar* addTerm "brak" (new TrapezoidFuzzySet 0.0 0.0 10.0 25.0))
(?*OpadFvar* addTerm "lekki" (new TrapezoidFuzzySet 5.0 25.0 35.0 50.0))
(?*OpadFvar* addTerm "mocny" (new TrapezoidFuzzySet 35.0 50.0 60.0 75.0))
(?*OpadFvar* addTerm "b_mocny" (new TrapezoidFuzzySet 60.0 75.0 100.0 100.0))


;;predkosc
(?*PredkoscFvar* addTerm "mala" (new TrapezoidFuzzySet 0.0 0.0 30.0 50.0))
(?*PredkoscFvar* addTerm "srednia" (new TrapezoidFuzzySet 30.0 50.0 75.0 100.0))
(?*PredkoscFvar* addTerm "duza" (new TrapezoidFuzzySet 75.0 100.0 120.0 150.0))
(?*PredkoscFvar* addTerm "b_duza" (new TrapezoidFuzzySet 130.0 160.0 250.0 250.0))
    
	
;;wycieraczki- ustawienia pracy
(?*WycieraczkiFvar* addTerm "wylaczone" (new TriangleFuzzySet 0.0 0.0 1.5))
(?*WycieraczkiFvar* addTerm "lekka" (new TriangleFuzzySet 1.0 2.5 4.5))
(?*WycieraczkiFvar* addTerm "mocna" (new TriangleFuzzySet 3.0 5.0 6.5))
(?*WycieraczkiFvar* addTerm "b_mocna" (new TriangleFuzzySet 5.5 7 8.5))
(?*WycieraczkiFvar* addTerm "maksymalna" (new TriangleFuzzySet 7.5 10.0 10.0))




(printout file "Sterownik rozmyty dla pracy wycireraczek" crlf) 
(printout file "" crlf)
(printout file "Na podstawie dwoch wartosci wejsciowych otrzymujemy wynik wyjsciowy bedacy intensywnoscia pracy wycieraczek, gdzie 0 to brak pracy, a 10 to praca maksynmalna." crlf) 
(printout file "" crlf)




 
(assert (crispOpad ?*zmOpad*))
(assert (Opad (new FuzzyValue ?*OpadFvar* (new TrapezoidFuzzySet ?*zmOpad* ?*zmOpad* ?*zmOpad* ?*zmOpad*))))

(assert (crispPredkosc ?*zmPredkosc*))
(assert (Predkosc (new FuzzyValue ?*PredkoscFvar* (new TrapezoidFuzzySet ?*zmPredkosc* ?*zmPredkosc* ?*zmPredkosc* ?*zmPredkosc*))))




)
(defrule regula1
(Opad ?tw&:(fuzzy-match ?tw "brak"))
(Predkosc ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "wylaczone"))))
    

(defrule regula2
(Opad ?tw&:(fuzzy-match ?tw "brak"))
(Predkosc ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "wylaczone"))))

(defrule regula3
(Opad ?tw&:(fuzzy-match ?tw "brak"))
(Predkosc ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "wylaczone"))))

(defrule regula4
(Opad ?tw&:(fuzzy-match ?tw "brak"))
(Predkosc ?tz&:(fuzzy-match ?tz "b_duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "wylaczone"))))
    
(defrule regula5
(Opad ?tw&:(fuzzy-match ?tw "lekki"))
(Predkosc ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "lekka"))))

(defrule regula6
(Opad ?tw&:(fuzzy-match ?tw "lekki"))
(Predkosc ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "lekka"))))

(defrule regula7
(Opad ?tw&:(fuzzy-match ?tw "lekki"))
(Predkosc ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "mocna"))))

(defrule regula8
(Opad ?tw&:(fuzzy-match ?tw "lekki"))
(Predkosc ?tz&:(fuzzy-match ?tz "b_duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "mocna"))))

(defrule regula9
(Opad ?tw&:(fuzzy-match ?tw "mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "mocna"))))

(defrule regula10
(Opad ?tw&:(fuzzy-match ?tw "mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "mocna"))))

(defrule regula11
(Opad ?tw&:(fuzzy-match ?tw "mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "b_mocna"))))

(defrule regula12
(Opad ?tw&:(fuzzy-match ?tw "mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "b_duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "b_mocna"))))

(defrule regula13
(Opad ?tw&:(fuzzy-match ?tw "b_mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "mala"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "b_mocna"))))

(defrule regula14
(Opad ?tw&:(fuzzy-match ?tw "b_mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "srednia"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "b_mocna"))))

(defrule regula15
(Opad ?tw&:(fuzzy-match ?tw "b_mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "maksymalna"))))

(defrule regula16
(Opad ?tw&:(fuzzy-match ?tw "b_mocny"))
(Predkosc ?tz&:(fuzzy-match ?tz "b_duza"))
=>
(bind ?*tempus* 1)
(assert (wycieraczki (new FuzzyValue ?*WycieraczkiFvar* "maksymalna"))))


(defrule control
(declare (salience -100))

?op <- (crispOpad ?tw)
?pr <- (crispPredkosc ?tz)


?wyc <- (wycieraczki ?fuzzyWycieraczki)


=>
   
    (bind ?crispWycieraczki (?fuzzyWycieraczki momentDefuzzify))
    
    
    (printout file "" crlf)
    (printout file "Dla opadow = " ?tw " , i predkosci  = " ?tz crlf)
    
        
  
    
    (bind ?zmienna1 (* ?crispWycieraczki 1))
    
    
       
   (bind ?aaa (round  (* ?zmienna1 100)))
    
   (bind ?aaaa (/ ?aaa 100))
   
    
    (printout file "" crlf)
    
    (printout file "Poziom wycieraczek ustawiono na : " ?aaaa crlf)  
    
         
    
    )


(reset)
(run)

(close file)
