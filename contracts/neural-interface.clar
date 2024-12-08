;; neural-interface contract

(define-data-var next-interface-id uint u0)

(define-map neural-interfaces
  { interface-id: uint }
  {
    owner: principal,
    name: (string-utf8 100),
    interface-type: (string-ascii 20),
    status: (string-ascii 20)
  }
)

(define-public (register-interface (name (string-utf8 100)) (interface-type (string-ascii 20)))
  (let
    (
      (interface-id (var-get next-interface-id))
    )
    (map-set neural-interfaces
      { interface-id: interface-id }
      {
        owner: tx-sender,
        name: name,
        interface-type: interface-type,
        status: "active"
      }
    )
    (var-set next-interface-id (+ interface-id u1))
    (ok interface-id)
  )
)

(define-public (update-interface-status (interface-id uint) (new-status (string-ascii 20)))
  (let
    (
      (interface (unwrap! (map-get? neural-interfaces { interface-id: interface-id }) (err u404)))
    )
    (asserts! (is-eq tx-sender (get owner interface)) (err u403))
    (ok (map-set neural-interfaces
      { interface-id: interface-id }
      (merge interface { status: new-status })
    ))
  )
)

(define-read-only (get-interface (interface-id uint))
  (map-get? neural-interfaces { interface-id: interface-id })
)

