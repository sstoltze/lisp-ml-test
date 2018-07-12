;; This file illustrates the issue I had reading comma separated floats (e.g. "12,2") using clml

(setf *read-default-float-format* 'double-float)
(ql:quickload :clml) ;; Go to quicklisp/local-projects and clone https://github.com/mmaul/clml

(defun setup-dataset (path)
  (clml.hjs.read-data:read-data-from-file
   (clml.utility.data:fetch path)
   :type :csv
   ;; This is good enough for now
   :csv-type-spec '(integer
                    integer
                    double-float
                    double-float
                    double-float
                    double-float
                    integer
                    string
                    string
                    string
                    integer
                    double-float
                    integer
                    double-float
                    integer
                    double-float
                    integer
                    double-float
                    nil
                    nil
                    nil)
   :csv-delimiter #\;))

;; Original dataset
(defvar churn-data (setup-dataset "./Churn.csv"))

;; Manually edited to replace , with .
(defvar churn-data-point (setup-dataset "./Churn-dot-decimal.csv"))

(format t "Original CSV. Notice how all decimals are still strings in the following expression:~%")
;; Notice how all decimals are still strings in the following expression:
(format t "~S~%" (clml.hjs.read-data:head-points churn-data))

(format t "File modified to replace ',' with '.'. This makes everything work as expected.~%")
;; While everything is alright in the following
(format t "~S~%" (clml.hjs.read-data:head-points churn-data-point))
