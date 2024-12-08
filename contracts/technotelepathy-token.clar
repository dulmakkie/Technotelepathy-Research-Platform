;; technotelepathy-token contract

(define-fungible-token technotelepathy-token)

(define-data-var token-uri (string-utf8 256) u"https://example.com/technotelepathy-token-metadata")

(define-public (mint (amount uint) (recipient principal))
  (ft-mint? technotelepathy-token amount recipient)
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (ft-transfer? technotelepathy-token amount sender recipient)
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance technotelepathy-token account))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply technotelepathy-token))
)

(define-public (reward-milestone (recipient principal) (amount uint))
  (ft-mint? technotelepathy-token amount recipient)
)

