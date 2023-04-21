(set-option :auto-config false)
(set-option :model true)

(set-option :smt.mbqi false)

(define-sort Str () Int)
(declare-fun strLen (Str) Int)
(declare-fun subString (Str Int Int) Str)
(declare-fun concatString (Str Str) Str)
(define-sort Elt () Int)
(define-sort LSet () (Array Elt Bool))
(define-fun smt_set_emp () LSet ((as const LSet) false))
(define-fun smt_set_sng ((x Elt)) LSet (store ((as const LSet) false) x true))
(define-fun smt_set_mem ((x Elt) (s LSet)) Bool (select s x))
(define-fun smt_set_add ((s LSet) (x Elt)) LSet (store s x true))
(define-fun smt_set_cup ((s1 LSet) (s2 LSet)) LSet ((_ map or) s1 s2))
(define-fun smt_set_cap ((s1 LSet) (s2 LSet)) LSet ((_ map and) s1 s2))
(define-fun smt_set_com ((s LSet)) LSet ((_ map not) s))
(define-fun smt_set_dif ((s1 LSet) (s2 LSet)) LSet (smt_set_cap s1 (smt_set_com s2)))
(define-fun smt_set_sub ((s1 LSet) (s2 LSet)) Bool (= smt_set_emp (smt_set_dif s1 s2)))
(define-sort Map () (Array Elt Elt))
(define-fun smt_map_sel ((m Map) (k Elt)) Elt (select m k))
(define-fun smt_map_sto ((m Map) (k Elt) (v Elt)) Map (store m k v))
(define-fun smt_map_cup ((m1 Map) (m2 Map)) Map ((_ map (+ (Elt Elt) Elt)) m1 m2))
(define-fun smt_map_prj ((s LSet) (m Map)) Map ((_ map (ite (Bool Elt Elt) Elt)) s m ((as const (Array Elt Elt)) 0)))
(define-fun smt_map_to_set ((m Map)) LSet ((_ map (> (Elt Elt) Bool)) m ((as const (Array Elt Elt)) 0)))
(define-fun smt_map_max ((m1 Map) (m2 Map)) Map (lambda ((i Int)) (ite (> (select m1 i) (select m2 i)) (select m1 i) (select m2 i))))
(define-fun smt_map_min ((m1 Map) (m2 Map)) Map (lambda ((i Int)) (ite (< (select m1 i) (select m2 i)) (select m1 i) (select m2 i))))
(define-fun smt_map_shift ((n Int) (m Map)) Map (lambda ((i Int)) (select m (- i n))))
(define-fun smt_map_def ((v Elt)) Map ((as const (Map)) v))
(define-fun bool_to_int ((b Bool)) Int (ite b 1 0))
(define-fun Z3_OP_MUL ((x Int) (y Int)) Int (* x y))
(define-fun Z3_OP_DIV ((x Int) (y Int)) Int (div x y))
(declare-datatypes ((Unit 0)) ((par () (Unit))))
(declare-datatypes ((Pair 2)) ((par (T0 T1) ((Pair (fst T0) (snd T1))))))
(declare-fun lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 () Int)
(declare-fun fix$36$_$35$2$35$$35$6 () Unit)
(declare-fun a0$35$$35$1 () Int)
(declare-fun a4$35$$35$5 () Int)
(declare-fun fix$36$_$35$1 () Unit)
(declare-fun a1 () Int)
(declare-fun a4 () Int)
(declare-fun fix$36$_$35$1$35$$35$4 () Unit)
(declare-fun nnf_arg$35$$35$k2$35$$35$2 () Int)
(declare-fun lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 () Int)
(declare-fun a2 () Int)
(declare-fun lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 () Int)
(declare-fun cast_as () Int)
(declare-fun cast_as_int () Int)
(declare-fun lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 () Int)
(declare-fun a2$35$$35$3 () Int)
(declare-fun a0 () Int)
(declare-fun lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 () Int)
(declare-fun fix$36$_$35$2 () Unit)
(declare-fun lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 () Int)
(declare-fun a5 () Int)
(declare-fun nnf_arg$35$$35$k2$35$$35$1 () Int)
(declare-fun fix$36$_$35$$35$2 () Unit)
(declare-fun fix$36$_ () Unit)
(declare-fun a3 () Int)
(declare-fun nnf_arg$35$$35$k1$35$$35$1 () Int)
(declare-fun apply$35$$35$16 (Int (_ BitVec 32)) Bool)
(declare-fun apply$35$$35$1 (Int Int) Bool)
(declare-fun apply$35$$35$3 (Int Int) (_ BitVec 32))
(declare-fun apply$35$$35$18 (Int (_ BitVec 32)) (_ BitVec 32))
(declare-fun apply$35$$35$24 (Int Unit) Unit)
(declare-fun apply$35$$35$17 (Int (_ BitVec 32)) Str)
(declare-fun apply$35$$35$11 (Int Str) Bool)
(declare-fun apply$35$$35$5 (Int Bool) Int)
(declare-fun apply$35$$35$12 (Int Str) Str)
(declare-fun apply$35$$35$4 (Int Int) Unit)
(declare-fun apply$35$$35$20 (Int Unit) Int)
(declare-fun apply$35$$35$13 (Int Str) (_ BitVec 32))
(declare-fun apply$35$$35$15 (Int (_ BitVec 32)) Int)
(declare-fun apply$35$$35$9 (Int Bool) Unit)
(declare-fun apply$35$$35$22 (Int Unit) Str)
(declare-fun apply$35$$35$10 (Int Str) Int)
(declare-fun apply$35$$35$0 (Int Int) Int)
(declare-fun apply$35$$35$7 (Int Bool) Str)
(declare-fun apply$35$$35$8 (Int Bool) (_ BitVec 32))
(declare-fun apply$35$$35$21 (Int Unit) Bool)
(declare-fun apply$35$$35$23 (Int Unit) (_ BitVec 32))
(declare-fun apply$35$$35$19 (Int (_ BitVec 32)) Unit)
(declare-fun apply$35$$35$2 (Int Int) Str)
(declare-fun apply$35$$35$6 (Int Bool) Bool)
(declare-fun apply$35$$35$14 (Int Str) Unit)
(declare-fun coerce$35$$35$16 ((_ BitVec 32)) Bool)
(declare-fun coerce$35$$35$1 (Int) Bool)
(declare-fun coerce$35$$35$3 (Int) (_ BitVec 32))
(declare-fun coerce$35$$35$18 ((_ BitVec 32)) (_ BitVec 32))
(declare-fun coerce$35$$35$24 (Unit) Unit)
(declare-fun coerce$35$$35$17 ((_ BitVec 32)) Str)
(declare-fun coerce$35$$35$11 (Str) Bool)
(declare-fun coerce$35$$35$5 (Bool) Int)
(declare-fun coerce$35$$35$12 (Str) Str)
(declare-fun coerce$35$$35$4 (Int) Unit)
(declare-fun coerce$35$$35$20 (Unit) Int)
(declare-fun coerce$35$$35$13 (Str) (_ BitVec 32))
(declare-fun coerce$35$$35$15 ((_ BitVec 32)) Int)
(declare-fun coerce$35$$35$9 (Bool) Unit)
(declare-fun coerce$35$$35$22 (Unit) Str)
(declare-fun coerce$35$$35$10 (Str) Int)
(declare-fun coerce$35$$35$0 (Int) Int)
(declare-fun coerce$35$$35$7 (Bool) Str)
(declare-fun coerce$35$$35$8 (Bool) (_ BitVec 32))
(declare-fun coerce$35$$35$21 (Unit) Bool)
(declare-fun coerce$35$$35$23 (Unit) (_ BitVec 32))
(declare-fun coerce$35$$35$19 ((_ BitVec 32)) Unit)
(declare-fun coerce$35$$35$2 (Int) Str)
(declare-fun coerce$35$$35$6 (Bool) Bool)
(declare-fun coerce$35$$35$14 (Str) Unit)
(declare-fun smt_lambda$35$$35$16 ((_ BitVec 32) Bool) Int)
(declare-fun smt_lambda$35$$35$1 (Int Bool) Int)
(declare-fun smt_lambda$35$$35$3 (Int (_ BitVec 32)) Int)
(declare-fun smt_lambda$35$$35$18 ((_ BitVec 32) (_ BitVec 32)) Int)
(declare-fun smt_lambda$35$$35$24 (Unit Unit) Int)
(declare-fun smt_lambda$35$$35$17 ((_ BitVec 32) Str) Int)
(declare-fun smt_lambda$35$$35$11 (Str Bool) Int)
(declare-fun smt_lambda$35$$35$5 (Bool Int) Int)
(declare-fun smt_lambda$35$$35$12 (Str Str) Int)
(declare-fun smt_lambda$35$$35$4 (Int Unit) Int)
(declare-fun smt_lambda$35$$35$20 (Unit Int) Int)
(declare-fun smt_lambda$35$$35$13 (Str (_ BitVec 32)) Int)
(declare-fun smt_lambda$35$$35$15 ((_ BitVec 32) Int) Int)
(declare-fun smt_lambda$35$$35$9 (Bool Unit) Int)
(declare-fun smt_lambda$35$$35$22 (Unit Str) Int)
(declare-fun smt_lambda$35$$35$10 (Str Int) Int)
(declare-fun smt_lambda$35$$35$0 (Int Int) Int)
(declare-fun smt_lambda$35$$35$7 (Bool Str) Int)
(declare-fun smt_lambda$35$$35$8 (Bool (_ BitVec 32)) Int)
(declare-fun smt_lambda$35$$35$21 (Unit Bool) Int)
(declare-fun smt_lambda$35$$35$23 (Unit (_ BitVec 32)) Int)
(declare-fun smt_lambda$35$$35$19 ((_ BitVec 32) Unit) Int)
(declare-fun smt_lambda$35$$35$2 (Int Str) Int)
(declare-fun smt_lambda$35$$35$6 (Bool Bool) Int)
(declare-fun smt_lambda$35$$35$14 (Str Unit) Int)
(declare-fun lam_arg$35$$35$1$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$2$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$3$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$4$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$5$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$6$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$7$35$$35$5 () Bool)
(declare-fun lam_arg$35$$35$1$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$2$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$3$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$4$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$5$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$6$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$7$35$$35$20 () Unit)
(declare-fun lam_arg$35$$35$1$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$2$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$3$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$4$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$5$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$6$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$7$35$$35$15 () (_ BitVec 32))
(declare-fun lam_arg$35$$35$1$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$2$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$3$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$4$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$5$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$6$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$7$35$$35$10 () Str)
(declare-fun lam_arg$35$$35$1$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$2$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$3$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$4$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$5$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$6$35$$35$0 () Int)
(declare-fun lam_arg$35$$35$7$35$$35$0 () Int)
(push 1)
(define-fun b$36$$35$$35$3 () Bool (= a0 0))
(define-fun b$36$$35$$35$6 () Bool (= a2 0))
(define-fun b$36$$35$$35$9 () Bool (= a4 2))
(define-fun b$36$$35$$35$12 () Bool (= a0$35$$35$1 0))
(define-fun b$36$$35$$35$14 () Bool (= a2$35$$35$3 0))
(define-fun b$36$$35$$35$16 () Bool (= a4$35$$35$5 2))
(push 1)
(push 1)
(assert (and (exists ((lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a1) (exists ((a0 Int) (a0$35$$35$1 Int)) (and (= a0 0) (= a0$35$$35$1 0) (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a0$35$$35$1))))) (exists ((lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a1) (exists ((a0 Int) (a0$35$$35$1 Int)) (and (= a0 0) (= a0$35$$35$1 0) (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a0$35$$35$1)))))))
(push 1)
(assert (not (<= a1 0)))
(check-sat)
(pop 1)
; SMT Says: Unsat
(pop 1)
(push 1)
(assert (and (exists ((lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a1) (exists ((a0 Int) (a0$35$$35$1 Int)) (and (= a0 0) (= a0$35$$35$1 0) (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a0$35$$35$1))))) (exists ((lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 Int) (lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1) (exists ((a2 Int) (a2$35$$35$3 Int)) (and (= a2 0) (= a2$35$$35$3 0) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a2$35$$35$3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1))))) (exists ((lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 Int) (lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1) (exists ((a2 Int) (a2$35$$35$3 Int)) (and (= a2 0) (= a2$35$$35$3 0) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a2$35$$35$3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1)))))))
(push 1)
(assert (not (<= a3 2)))
(check-sat)
(pop 1)
; SMT Says: Unsat
(pop 1)
(push 1)
(assert (and (exists ((lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a1) (exists ((a0 Int) (a0$35$$35$1 Int)) (and (= a0 0) (= a0$35$$35$1 0) (= lq_karg$36$nnf_arg$35$$35$k0$35$$35$0$35$$35$k0 a0$35$$35$1))))) (exists ((lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 Int) (lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1) (exists ((a2 Int) (a2$35$$35$3 Int)) (and (= a2 0) (= a2$35$$35$3 0) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$0$35$$35$k1 a2$35$$35$3) (= lq_karg$36$nnf_arg$35$$35$k1$35$$35$1$35$$35$k1 a1))))) (exists ((lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 Int) (lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 Int) (lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 a5) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 a1) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 a3) (exists ((a4 Int) (a4$35$$35$5 Int)) (and (= a4 2) (= a4$35$$35$5 2) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 a4$35$$35$5) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 a1) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 a3))))) (exists ((lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 Int) (lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 Int) (lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 Int)) (and (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 a5) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 a1) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 a3) (exists ((a4 Int) (a4$35$$35$5 Int)) (and (= a4 2) (= a4$35$$35$5 2) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$0$35$$35$k2 a4$35$$35$5) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$1$35$$35$k2 a1) (= lq_karg$36$nnf_arg$35$$35$k2$35$$35$2$35$$35$k2 a3)))))))
(push 1)
(assert (not (<= a5 1)))
(check-sat)
(pop 1)
; SMT Says: Sat
(pop 1)
(pop 1)
(pop 1)
(exit)