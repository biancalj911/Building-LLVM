; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basicaa -slp-vectorizer -dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

; int foo(double * restrict A, double * restrict B, double G) {
;   A[0] = (B[10] ? G : 1);
;   A[1] = (B[11] ? G : 1);
; }

define i32 @foo(double* noalias nocapture %A, double* noalias nocapture %B, double %G) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, double* [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast double* [[ARRAYIDX]] to <2 x double>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* [[TMP0]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = fcmp une <2 x double> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x double> undef, double [[G:%.*]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x double> [[TMP3]], double [[G]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = select <2 x i1> [[TMP2]], <2 x double> [[TMP4]], <2 x double> <double 1.000000e+00, double 1.000000e+00>
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast double* [[A:%.*]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP5]], <2 x double>* [[TMP6]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %arrayidx = getelementptr inbounds double, double* %B, i64 10
  %0 = load double, double* %arrayidx, align 8
  %tobool = fcmp une double %0, 0.000000e+00
  %cond = select i1 %tobool, double %G, double 1.000000e+00
  store double %cond, double* %A, align 8
  %arrayidx2 = getelementptr inbounds double, double* %B, i64 11
  %1 = load double, double* %arrayidx2, align 8
  %tobool3 = fcmp une double %1, 0.000000e+00
  %cond7 = select i1 %tobool3, double %G, double 1.000000e+00
  %arrayidx8 = getelementptr inbounds double, double* %A, i64 1
  store double %cond7, double* %arrayidx8, align 8
  ret i32 undef
}

