(require '[clojure.string :as str])
(use 'clojure.java.io)

(defn countGroups [text]
    (def record {:stack '(), :count 0})
    ((reduce 
        (fn [acc e]
            (if (= (peek (acc :stack)) "!")
                {:stack (pop (acc :stack)), :count (acc :count)}
                (case (str e)
                    "!" {:stack (conj (acc :stack) "!"), :count (acc :count)}
                    "<" (if (= (peek (acc :stack)) "<")
                        acc
                        {:stack (conj (acc :stack) "<"), :count (acc :count)}
                    )
                    ">" (if (= (peek (acc :stack)) "<")
                        {:stack (pop (acc :stack)), :count (acc :count)}
                        acc
                    )
                    "{" (if (= (peek (acc :stack)) "<")
                        acc
                        {:stack (conj (acc :stack) "{"), :count (acc :count)}
                    )
                    "}" (if (= (peek (acc :stack)) "<")
                        acc
                        {:stack (pop (acc :stack)), :count (+ (acc :count) (count (acc :stack)))}
                    )
                    acc
                )
            )
        )
        record
        (seq text)
    ) :count)
)

(println "Running tests.")
(with-open [exampleReader (reader "./09/example.txt")]
    (if (reduce
            (fn [acc e]
                (let [
                    tokens (str/split e #" ")
                    input (first tokens)
                    expected (second tokens)
                ]
                (and acc (= (countGroups input) (read-string expected)))
                )
            )
            true
            (line-seq exampleReader)
        )
        (
            (println "Tests passed. Running on input.")
            (with-open [inputReader (reader "./09/input.txt")]
                (println (str "Final answer: " (countGroups (first (line-seq inputReader)))))
            )
        )
        (println "Tests failed")
    )
)