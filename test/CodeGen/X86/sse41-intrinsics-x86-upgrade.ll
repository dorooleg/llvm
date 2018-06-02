; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-peephole -mtriple=i386-apple-darwin -mattr=+sse4.1 -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,SSE,X86-SSE
; RUN: llc < %s -disable-peephole -mtriple=i386-apple-darwin -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX1,X86-AVX1
; RUN: llc < %s -disable-peephole -mtriple=i386-apple-darwin -mattr=+avx512f -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX512,X86-AVX512
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+sse4.1 -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,SSE,X64-SSE
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX1,X64-AVX1
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+avx512f -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX512,X64-AVX512

; This test works just like the non-upgrade one except that it only checks
; forms which require auto-upgrading.

define <2 x double> @test_x86_sse41_blendpd(<2 x double> %a0, <2 x double> %a1) {
; SSE-LABEL: test_x86_sse41_blendpd:
; SSE:       ## %bb.0:
; SSE-NEXT:    blendps $12, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x0c,0xc1,0x0c]
; SSE-NEXT:    ## xmm0 = xmm0[0,1],xmm1[2,3]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse41_blendpd:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vblendps $3, %xmm0, %xmm1, %xmm0 ## encoding: [0xc4,0xe3,0x71,0x0c,0xc0,0x03]
; AVX1-NEXT:    ## xmm0 = xmm0[0,1],xmm1[2,3]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse41_blendpd:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vmovsd %xmm0, %xmm1, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xf3,0x10,0xc0]
; AVX512-NEXT:    ## xmm0 = xmm0[0],xmm1[1]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x double> @llvm.x86.sse41.blendpd(<2 x double> %a0, <2 x double> %a1, i32 6) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.blendpd(<2 x double>, <2 x double>, i32) nounwind readnone


define <4 x float> @test_x86_sse41_blendps(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse41_blendps:
; SSE:       ## %bb.0:
; SSE-NEXT:    blendps $7, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x0c,0xc1,0x07]
; SSE-NEXT:    ## xmm0 = xmm1[0,1,2],xmm0[3]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_blendps:
; AVX:       ## %bb.0:
; AVX-NEXT:    vblendps $8, %xmm0, %xmm1, %xmm0 ## encoding: [0xc4,0xe3,0x71,0x0c,0xc0,0x08]
; AVX-NEXT:    ## xmm0 = xmm1[0,1,2],xmm0[3]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse41.blendps(<4 x float> %a0, <4 x float> %a1, i32 7) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.blendps(<4 x float>, <4 x float>, i32) nounwind readnone


define <2 x double> @test_x86_sse41_dppd(<2 x double> %a0, <2 x double> %a1) {
; SSE-LABEL: test_x86_sse41_dppd:
; SSE:       ## %bb.0:
; SSE-NEXT:    dppd $7, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x41,0xc1,0x07]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_dppd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vdppd $7, %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe3,0x79,0x41,0xc1,0x07]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x double> @llvm.x86.sse41.dppd(<2 x double> %a0, <2 x double> %a1, i32 7) ; <<2 x double>> [#uses=1]
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.dppd(<2 x double>, <2 x double>, i32) nounwind readnone


define <4 x float> @test_x86_sse41_dpps(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse41_dpps:
; SSE:       ## %bb.0:
; SSE-NEXT:    dpps $7, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x40,0xc1,0x07]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_dpps:
; AVX:       ## %bb.0:
; AVX-NEXT:    vdpps $7, %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe3,0x79,0x40,0xc1,0x07]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse41.dpps(<4 x float> %a0, <4 x float> %a1, i32 7) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.dpps(<4 x float>, <4 x float>, i32) nounwind readnone


define <4 x float> @test_x86_sse41_insertps(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse41_insertps:
; SSE:       ## %bb.0:
; SSE-NEXT:    insertps $17, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x21,0xc1,0x11]
; SSE-NEXT:    ## xmm0 = zero,xmm1[0],xmm0[2,3]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse41_insertps:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vinsertps $17, %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe3,0x79,0x21,0xc1,0x11]
; AVX1-NEXT:    ## xmm0 = zero,xmm1[0],xmm0[2,3]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse41_insertps:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vinsertps $17, %xmm1, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc4,0xe3,0x79,0x21,0xc1,0x11]
; AVX512-NEXT:    ## xmm0 = zero,xmm1[0],xmm0[2,3]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse41.insertps(<4 x float> %a0, <4 x float> %a1, i32 17) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.insertps(<4 x float>, <4 x float>, i32) nounwind readnone


define <2 x i64> @test_x86_sse41_movntdqa(<2 x i64>* %a0) {
; X86-SSE-LABEL: test_x86_sse41_movntdqa:
; X86-SSE:       ## %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax ## encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movntdqa (%eax), %xmm0 ## encoding: [0x66,0x0f,0x38,0x2a,0x00]
; X86-SSE-NEXT:    retl ## encoding: [0xc3]
;
; X86-AVX-LABEL: test_x86_sse41_movntdqa:
; X86-AVX:       ## %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax ## encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovntdqa (%eax), %xmm0 ## encoding: [0xc4,0xe2,0x79,0x2a,0x00]
; X86-AVX-NEXT:    retl ## encoding: [0xc3]
;
; X64-SSE-LABEL: test_x86_sse41_movntdqa:
; X64-SSE:       ## %bb.0:
; X64-SSE-NEXT:    movntdqa (%rdi), %xmm0 ## encoding: [0x66,0x0f,0x38,0x2a,0x07]
; X64-SSE-NEXT:    retq ## encoding: [0xc3]
;
; X64-AVX-LABEL: test_x86_sse41_movntdqa:
; X64-AVX:       ## %bb.0:
; X64-AVX-NEXT:    vmovntdqa (%rdi), %xmm0 ## encoding: [0xc4,0xe2,0x79,0x2a,0x07]
; X64-AVX-NEXT:    retq ## encoding: [0xc3]
  %arg0 = bitcast <2 x i64>* %a0 to i8*
  %res = call <2 x i64> @llvm.x86.sse41.movntdqa(i8* %arg0)
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.movntdqa(i8*) nounwind readnone


define <8 x i16> @test_x86_sse41_mpsadbw(<16 x i8> %a0, <16 x i8> %a1) {
; SSE-LABEL: test_x86_sse41_mpsadbw:
; SSE:       ## %bb.0:
; SSE-NEXT:    mpsadbw $7, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x42,0xc1,0x07]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_mpsadbw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vmpsadbw $7, %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe3,0x79,0x42,0xc1,0x07]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> %a0, <16 x i8> %a1, i32 7) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8>, <16 x i8>, i32) nounwind readnone


define <8 x i16> @test_x86_sse41_pblendw(<8 x i16> %a0, <8 x i16> %a1) {
; SSE-LABEL: test_x86_sse41_pblendw:
; SSE:       ## %bb.0:
; SSE-NEXT:    pblendw $7, %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x3a,0x0e,0xc1,0x07]
; SSE-NEXT:    ## xmm0 = xmm1[0,1,2],xmm0[3,4,5,6,7]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pblendw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpblendw $7, %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe3,0x79,0x0e,0xc1,0x07]
; AVX-NEXT:    ## xmm0 = xmm1[0,1,2],xmm0[3,4,5,6,7]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.pblendw(<8 x i16> %a0, <8 x i16> %a1, i32 7) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.pblendw(<8 x i16>, <8 x i16>, i32) nounwind readnone


define <4 x i32> @test_x86_sse41_pmovsxbd(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxbd:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxbd %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x21,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxbd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbd %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x21,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmovsxbd(<16 x i8> %a0) ; <<4 x i32>> [#uses=1]
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmovsxbd(<16 x i8>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovsxbq(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxbq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxbq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x22,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxbq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x22,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovsxbq(<16 x i8> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovsxbq(<16 x i8>) nounwind readnone


define <8 x i16> @test_x86_sse41_pmovsxbw(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxbw:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxbw %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x20,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxbw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbw %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x20,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.pmovsxbw(<16 x i8> %a0) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.pmovsxbw(<16 x i8>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovsxdq(<4 x i32> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxdq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxdq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x25,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxdq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxdq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x25,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovsxdq(<4 x i32> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovsxdq(<4 x i32>) nounwind readnone


define <4 x i32> @test_x86_sse41_pmovsxwd(<8 x i16> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxwd:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxwd %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x23,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxwd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxwd %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x23,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmovsxwd(<8 x i16> %a0) ; <<4 x i32>> [#uses=1]
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmovsxwd(<8 x i16>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovsxwq(<8 x i16> %a0) {
; SSE-LABEL: test_x86_sse41_pmovsxwq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovsxwq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x24,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovsxwq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxwq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x24,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovsxwq(<8 x i16> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovsxwq(<8 x i16>) nounwind readnone


define <4 x i32> @test_x86_sse41_pmovzxbd(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxbd:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxbd %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x31,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxbd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbd %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x31,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmovzxbd(<16 x i8> %a0) ; <<4 x i32>> [#uses=1]
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmovzxbd(<16 x i8>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovzxbq(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxbq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxbq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x32,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxbq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x32,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovzxbq(<16 x i8> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovzxbq(<16 x i8>) nounwind readnone


define <8 x i16> @test_x86_sse41_pmovzxbw(<16 x i8> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxbw:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxbw %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x30,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxbw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbw %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x30,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.pmovzxbw(<16 x i8> %a0) ; <<8 x i16>> [#uses=1]
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.pmovzxbw(<16 x i8>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovzxdq(<4 x i32> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxdq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxdq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x35,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxdq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxdq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x35,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovzxdq(<4 x i32> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovzxdq(<4 x i32>) nounwind readnone


define <4 x i32> @test_x86_sse41_pmovzxwd(<8 x i16> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxwd:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxwd %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x33,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxwd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxwd %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x33,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmovzxwd(<8 x i16> %a0) ; <<4 x i32>> [#uses=1]
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmovzxwd(<8 x i16>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmovzxwq(<8 x i16> %a0) {
; SSE-LABEL: test_x86_sse41_pmovzxwq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmovzxwq %xmm0, %xmm0 ## encoding: [0x66,0x0f,0x38,0x34,0xc0]
; SSE-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmovzxwq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxwq %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x34,0xc0]
; AVX-NEXT:    ## xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmovzxwq(<8 x i16> %a0) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmovzxwq(<8 x i16>) nounwind readnone

define <16 x i8> @max_epi8(<16 x i8> %a0, <16 x i8> %a1) {
; SSE-LABEL: max_epi8:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmaxsb %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3c,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: max_epi8:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3c,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <16 x i8> @llvm.x86.sse41.pmaxsb(<16 x i8> %a0, <16 x i8> %a1)
  ret <16 x i8> %res
}
declare <16 x i8> @llvm.x86.sse41.pmaxsb(<16 x i8>, <16 x i8>) nounwind readnone

define <16 x i8> @min_epi8(<16 x i8> %a0, <16 x i8> %a1) {
; SSE-LABEL: min_epi8:
; SSE:       ## %bb.0:
; SSE-NEXT:    pminsb %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x38,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: min_epi8:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x38,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <16 x i8> @llvm.x86.sse41.pminsb(<16 x i8> %a0, <16 x i8> %a1)
  ret <16 x i8> %res
}
declare <16 x i8> @llvm.x86.sse41.pminsb(<16 x i8>, <16 x i8>) nounwind readnone

define <8 x i16> @max_epu16(<8 x i16> %a0, <8 x i16> %a1) {
; SSE-LABEL: max_epu16:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmaxuw %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3e,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: max_epu16:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmaxuw %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3e,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.pmaxuw(<8 x i16> %a0, <8 x i16> %a1)
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.pmaxuw(<8 x i16>, <8 x i16>) nounwind readnone

define <8 x i16> @min_epu16(<8 x i16> %a0, <8 x i16> %a1) {
; SSE-LABEL: min_epu16:
; SSE:       ## %bb.0:
; SSE-NEXT:    pminuw %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3a,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: min_epu16:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpminuw %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3a,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <8 x i16> @llvm.x86.sse41.pminuw(<8 x i16> %a0, <8 x i16> %a1)
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.sse41.pminuw(<8 x i16>, <8 x i16>) nounwind readnone

define <4 x i32> @max_epi32(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: max_epi32:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmaxsd %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3d,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: max_epi32:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3d,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmaxsd(<4 x i32> %a0, <4 x i32> %a1)
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmaxsd(<4 x i32>, <4 x i32>) nounwind readnone

define <4 x i32> @min_epi32(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: min_epi32:
; SSE:       ## %bb.0:
; SSE-NEXT:    pminsd %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x39,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: min_epi32:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x39,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pminsd(<4 x i32> %a0, <4 x i32> %a1)
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pminsd(<4 x i32>, <4 x i32>) nounwind readnone

define <4 x i32> @max_epu32(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: max_epu32:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmaxud %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3f,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: max_epu32:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmaxud %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3f,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pmaxud(<4 x i32> %a0, <4 x i32> %a1)
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pmaxud(<4 x i32>, <4 x i32>) nounwind readnone

define <4 x i32> @min_epu32(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: min_epu32:
; SSE:       ## %bb.0:
; SSE-NEXT:    pminud %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x3b,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: min_epu32:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x3b,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x i32> @llvm.x86.sse41.pminud(<4 x i32> %a0, <4 x i32> %a1)
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.sse41.pminud(<4 x i32>, <4 x i32>) nounwind readnone


define <2 x i64> @test_x86_sse41_pmuldq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: test_x86_sse41_pmuldq:
; SSE:       ## %bb.0:
; SSE-NEXT:    pmuldq %xmm1, %xmm0 ## encoding: [0x66,0x0f,0x38,0x28,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse41_pmuldq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmuldq %xmm1, %xmm0, %xmm0 ## encoding: [0xc4,0xe2,0x79,0x28,0xc1]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.sse41.pmuldq(<4 x i32> %a0, <4 x i32> %a1) ; <<2 x i64>> [#uses=1]
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmuldq(<4 x i32>, <4 x i32>) nounwind readnone
