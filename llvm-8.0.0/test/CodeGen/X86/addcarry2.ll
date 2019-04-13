; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown --show-mc-encoding | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown       --show-mc-encoding | FileCheck %s --check-prefix=X64

define void @adc_load_store_64_15(i64* inreg %x, i64* inreg %x2, i64 inreg %y) nounwind {
; X32-LABEL: adc_load_store_64_15:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x08]
; X32-NEXT:    addl $1, %ecx # encoding: [0x83,0xc1,0x01]
; X32-NEXT:    adcl $0, %esi # encoding: [0x83,0xd6,0x00]
; X32-NEXT:    adcl $15, (%eax) # encoding: [0x83,0x10,0x0f]
; X32-NEXT:    adcl $0, 4(%eax) # encoding: [0x83,0x50,0x04,0x00]
; X32-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X32-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X32-NEXT:    movl %eax, (%edx) # encoding: [0x89,0x02]
; X32-NEXT:    movl $0, 4(%edx) # encoding: [0xc7,0x42,0x04,0x00,0x00,0x00,0x00]
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_64_15:
; X64:       # %bb.0:
; X64-NEXT:    addq $1, %rdx # encoding: [0x48,0x83,0xc2,0x01]
; X64-NEXT:    adcq $15, (%rdi) # encoding: [0x48,0x83,0x17,0x0f]
; X64-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X64-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X64-NEXT:    movq %rax, (%rsi) # encoding: [0x48,0x89,0x06]
; X64-NEXT:    retq # encoding: [0xc3]
  %vx   = load i64, i64* %x
  %zvx  = zext i64 %vx to i192
  %szvx = shl i192 %zvx, 64
  %zy   = zext i64 %y to i192
  %op   = or i192 %szvx, %zy
  %zsum = add i192 %op, 276701161105643274241 ; 0x0000_0000_0000_0000__0000_0000_0000_000F__0000_0000_0000_0001
  %ssum = lshr i192 %zsum, 64
  %val = trunc i192 %ssum to i64
  store i64 %val, i64* %x
  %ssum2 = lshr i192 %zsum, 128
  %val2 = trunc i192 %ssum2 to i64
  store i64 %val2, i64* %x2
  ret void
}

define void @adc_load_store_64_0x1000F(i64* inreg %x, i64* inreg %x2, i64 inreg %y) nounwind {
; X32-LABEL: adc_load_store_64_0x1000F:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x08]
; X32-NEXT:    addl $1, %ecx # encoding: [0x83,0xc1,0x01]
; X32-NEXT:    adcl $0, %esi # encoding: [0x83,0xd6,0x00]
; X32-NEXT:    adcl $65551, (%eax) # encoding: [0x81,0x10,0x0f,0x00,0x01,0x00]
; X32-NEXT:    # imm = 0x1000F
; X32-NEXT:    adcl $0, 4(%eax) # encoding: [0x83,0x50,0x04,0x00]
; X32-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X32-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X32-NEXT:    movl %eax, (%edx) # encoding: [0x89,0x02]
; X32-NEXT:    movl $0, 4(%edx) # encoding: [0xc7,0x42,0x04,0x00,0x00,0x00,0x00]
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_64_0x1000F:
; X64:       # %bb.0:
; X64-NEXT:    addq $1, %rdx # encoding: [0x48,0x83,0xc2,0x01]
; X64-NEXT:    adcq $65551, (%rdi) # encoding: [0x48,0x81,0x17,0x0f,0x00,0x01,0x00]
; X64-NEXT:    # imm = 0x1000F
; X64-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X64-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X64-NEXT:    movq %rax, (%rsi) # encoding: [0x48,0x89,0x06]
; X64-NEXT:    retq # encoding: [0xc3]
  %vx   = load i64, i64* %x
  %zvx  = zext i64 %vx to i192
  %szvx = shl i192 %zvx, 64
  %zy   = zext i64 %y to i192
  %op   = or i192 %szvx, %zy
  %zsum = add i192 %op, 1209202520775734817980417 ; 0x0000_0000_0000_0000__0000_0000_0001_000F__0000_0000_0000_0001
  %ssum = lshr i192 %zsum, 64
  %val = trunc i192 %ssum to i64
  store i64 %val, i64* %x
  %ssum2 = lshr i192 %zsum, 128
  %val2 = trunc i192 %ssum2 to i64
  store i64 %val2, i64* %x2
  ret void
}

define void @adc_load_store_64_0x100001000F(i64* inreg %x, i64* inreg %x2, i64 inreg %y) nounwind {
; X32-LABEL: adc_load_store_64_0x100001000F:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x08]
; X32-NEXT:    addl $1, %ecx # encoding: [0x83,0xc1,0x01]
; X32-NEXT:    adcl $0, %esi # encoding: [0x83,0xd6,0x00]
; X32-NEXT:    adcl $15, (%eax) # encoding: [0x83,0x10,0x0f]
; X32-NEXT:    adcl $16, 4(%eax) # encoding: [0x83,0x50,0x04,0x10]
; X32-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X32-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X32-NEXT:    movl %eax, (%edx) # encoding: [0x89,0x02]
; X32-NEXT:    movl $0, 4(%edx) # encoding: [0xc7,0x42,0x04,0x00,0x00,0x00,0x00]
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_64_0x100001000F:
; X64:       # %bb.0:
; X64-NEXT:    addq $1, %rdx # encoding: [0x48,0x83,0xc2,0x01]
; X64-NEXT:    movabsq $68719476751, %rax # encoding: [0x48,0xb8,0x0f,0x00,0x00,0x00,0x10,0x00,0x00,0x00]
; X64-NEXT:    # imm = 0x100000000F
; X64-NEXT:    adcq %rax, (%rdi) # encoding: [0x48,0x11,0x07]
; X64-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X64-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X64-NEXT:    movq %rax, (%rsi) # encoding: [0x48,0x89,0x06]
; X64-NEXT:    retq # encoding: [0xc3]
  %vx   = load i64, i64* %x
  %zvx  = zext i64 %vx to i192
  %szvx = shl i192 %zvx, 64
  %zy   = zext i64 %y to i192
  %op   = or i192 %szvx, %zy
  %zsum = add i192 %op, 1267650600504930562602346479617 ; 0x0000_0000_0000_0000__0000_0010_0000_000F__0000_0000_0000_0001
  %ssum = lshr i192 %zsum, 64
  %val = trunc i192 %ssum to i64
  store i64 %val, i64* %x
  %ssum2 = lshr i192 %zsum, 128
  %val2 = trunc i192 %ssum2 to i64
  store i64 %val2, i64* %x2
  ret void
}

define void @adc_load_store_32_127(i32* inreg %x, i32* inreg %x2, i32 inreg %y) nounwind {
; X32-LABEL: adc_load_store_32_127:
; X32:       # %bb.0:
; X32-NEXT:    addl $1, %ecx # encoding: [0x83,0xc1,0x01]
; X32-NEXT:    adcl $127, (%eax) # encoding: [0x83,0x10,0x7f]
; X32-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X32-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X32-NEXT:    movl %eax, (%edx) # encoding: [0x89,0x02]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_32_127:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax # encoding: [0x8b,0x07]
; X64-NEXT:    shlq $32, %rax # encoding: [0x48,0xc1,0xe0,0x20]
; X64-NEXT:    movl %edx, %ecx # encoding: [0x89,0xd1]
; X64-NEXT:    orq %rax, %rcx # encoding: [0x48,0x09,0xc1]
; X64-NEXT:    movabsq $545460846593, %rax # encoding: [0x48,0xb8,0x01,0x00,0x00,0x00,0x7f,0x00,0x00,0x00]
; X64-NEXT:    # imm = 0x7F00000001
; X64-NEXT:    xorl %edx, %edx # encoding: [0x31,0xd2]
; X64-NEXT:    addq %rcx, %rax # encoding: [0x48,0x01,0xc8]
; X64-NEXT:    setb %dl # encoding: [0x0f,0x92,0xc2]
; X64-NEXT:    shrq $32, %rax # encoding: [0x48,0xc1,0xe8,0x20]
; X64-NEXT:    movl %eax, (%rdi) # encoding: [0x89,0x07]
; X64-NEXT:    movl %edx, (%rsi) # encoding: [0x89,0x16]
; X64-NEXT:    retq # encoding: [0xc3]
  %vx   = load i32, i32* %x
  %zvx  = zext i32 %vx to i96
  %szvx = shl i96 %zvx, 32
  %zy   = zext i32 %y to i96
  %op   = or i96 %szvx, %zy
  %zsum = add i96 %op, 545460846593 ; 0x0000_0000__0000_007F__0000_0001
  %ssum = lshr i96 %zsum, 32
  %val = trunc i96 %ssum to i32
  store i32 %val, i32* %x
  %ssum2 = lshr i96 %zsum, 64
  %val2 = trunc i96 %ssum2 to i32
  store i32 %val2, i32* %x2
  ret void
}

define void @adc_load_store_32_128(i32* inreg %x, i32* inreg %x2, i32 inreg %y) nounwind {
; X32-LABEL: adc_load_store_32_128:
; X32:       # %bb.0:
; X32-NEXT:    addl $1, %ecx # encoding: [0x83,0xc1,0x01]
; X32-NEXT:    adcl $128, (%eax) # encoding: [0x81,0x10,0x80,0x00,0x00,0x00]
; X32-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; X32-NEXT:    movzbl %al, %eax # encoding: [0x0f,0xb6,0xc0]
; X32-NEXT:    movl %eax, (%edx) # encoding: [0x89,0x02]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_32_128:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax # encoding: [0x8b,0x07]
; X64-NEXT:    shlq $32, %rax # encoding: [0x48,0xc1,0xe0,0x20]
; X64-NEXT:    movl %edx, %ecx # encoding: [0x89,0xd1]
; X64-NEXT:    orq %rax, %rcx # encoding: [0x48,0x09,0xc1]
; X64-NEXT:    movabsq $549755813889, %rax # encoding: [0x48,0xb8,0x01,0x00,0x00,0x00,0x80,0x00,0x00,0x00]
; X64-NEXT:    # imm = 0x8000000001
; X64-NEXT:    xorl %edx, %edx # encoding: [0x31,0xd2]
; X64-NEXT:    addq %rcx, %rax # encoding: [0x48,0x01,0xc8]
; X64-NEXT:    setb %dl # encoding: [0x0f,0x92,0xc2]
; X64-NEXT:    shrq $32, %rax # encoding: [0x48,0xc1,0xe8,0x20]
; X64-NEXT:    movl %eax, (%rdi) # encoding: [0x89,0x07]
; X64-NEXT:    movl %edx, (%rsi) # encoding: [0x89,0x16]
; X64-NEXT:    retq # encoding: [0xc3]
  %vx   = load i32, i32* %x
  %zvx  = zext i32 %vx to i96
  %szvx = shl i96 %zvx, 32
  %zy   = zext i32 %y to i96
  %op   = or i96 %szvx, %zy
  %zsum = add i96 %op, 549755813889 ; 0x0000_0000__0000_0080__0000_0001
  %ssum = lshr i96 %zsum, 32
  %val = trunc i96 %ssum to i32
  store i32 %val, i32* %x
  %ssum2 = lshr i96 %zsum, 64
  %val2 = trunc i96 %ssum2 to i32
  store i32 %val2, i32* %x2
  ret void
}

; These tests all verify the load-op-store fusion does not generate
; larger instructions than mainline DAG Instruction selection.

define void @adc_load_store_8_15(i64 inreg %ca, i64 inreg %cb, i8* inreg %x) nounwind {
; X32-LABEL: adc_load_store_8_15:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x0c]
; X32-NEXT:    addl %ecx, %eax # encoding: [0x01,0xc8]
; X32-NEXT:    adcl {{[0-9]+}}(%esp), %edx # encoding: [0x13,0x54,0x24,0x08]
; X32-NEXT:    adcb $15, (%esi) # encoding: [0x80,0x16,0x0f]
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_8_15:
; X64:       # %bb.0:
; X64-NEXT:    addq %rsi, %rdi # encoding: [0x48,0x01,0xf7]
; X64-NEXT:    adcb $15, (%rdx) # encoding: [0x80,0x12,0x0f]
; X64-NEXT:    retq # encoding: [0xc3]
  %zca = zext i64 %ca to i65
  %zcb = zext i64 %cb to i65
  %zc = add i65 %zca, %zcb
  %ec = lshr i65 %zc, 64
  %c = trunc i65 %ec to i1
  %cc = zext i1 %c to i8
  %vx = load i8, i8* %x
  %cc_off = add i8 15, %cc
  %vsum = add i8 %vx, %cc_off
  store i8 %vsum, i8* %x
  ret void
}

define void @adc_load_store_16_15(i64 inreg %ca, i64 inreg %cb, i16* inreg %x) nounwind {
; X32-LABEL: adc_load_store_16_15:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x0c]
; X32-NEXT:    addl %ecx, %eax # encoding: [0x01,0xc8]
; X32-NEXT:    adcl {{[0-9]+}}(%esp), %edx # encoding: [0x13,0x54,0x24,0x08]
; X32-NEXT:    adcw $15, (%esi) # encoding: [0x66,0x83,0x16,0x0f]
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_16_15:
; X64:       # %bb.0:
; X64-NEXT:    addq %rsi, %rdi # encoding: [0x48,0x01,0xf7]
; X64-NEXT:    adcw $15, (%rdx) # encoding: [0x66,0x83,0x12,0x0f]
; X64-NEXT:    retq # encoding: [0xc3]
  %zca = zext i64 %ca to i65
  %zcb = zext i64 %cb to i65
  %zc = add i65 %zca, %zcb
  %ec = lshr i65 %zc, 64
  %c = trunc i65 %ec to i1
  %cc = zext i1 %c to i16
  %vx = load i16, i16* %x
  %cc_off = add i16 15, %cc
  %vsum = add i16 %vx, %cc_off
  store i16 %vsum, i16* %x
  ret void
}

define void @adc_load_store_16_256(i64 inreg %ca, i64 inreg %cb, i16* inreg %x) nounwind {
; X32-LABEL: adc_load_store_16_256:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi # encoding: [0x56]
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x0c]
; X32-NEXT:    addl %ecx, %eax # encoding: [0x01,0xc8]
; X32-NEXT:    adcl {{[0-9]+}}(%esp), %edx # encoding: [0x13,0x54,0x24,0x08]
; X32-NEXT:    adcw $256, (%esi) # encoding: [0x66,0x81,0x16,0x00,0x01]
; X32-NEXT:    # imm = 0x100
; X32-NEXT:    popl %esi # encoding: [0x5e]
; X32-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: adc_load_store_16_256:
; X64:       # %bb.0:
; X64-NEXT:    addq %rsi, %rdi # encoding: [0x48,0x01,0xf7]
; X64-NEXT:    adcw $256, (%rdx) # encoding: [0x66,0x81,0x12,0x00,0x01]
; X64-NEXT:    # imm = 0x100
; X64-NEXT:    retq # encoding: [0xc3]
  %zca = zext i64 %ca to i65
  %zcb = zext i64 %cb to i65
  %zc = add i65 %zca, %zcb
  %ec = lshr i65 %zc, 64
  %c = trunc i65 %ec to i1
  %cc = zext i1 %c to i16
  %vx = load i16, i16* %x
  %cc_off = add i16 256, %cc
  %vsum = add i16 %vx, %cc_off
  store i16 %vsum, i16* %x
  ret void
}
