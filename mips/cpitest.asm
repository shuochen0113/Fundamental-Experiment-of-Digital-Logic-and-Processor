# .data
# buffer: .space 4004
# input_file: .asciiz "a.in"
# output_file: .asciiz "a.out"

# .text

    # 先往硬件里存地址表，存在RAM�?0-15
    addi $t0, $zero, 0x10010040
    addi $t1, $zero, 0x0014
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x000041a8 # 1
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00003af2 # 2
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0000acda # 3
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00000c2b # 4
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0000b783 # 5
    sw $t1, 0($t0)
    addi $t0, $t0, 4  
    addi $t1, $zero, 0x0000dac9 # 6
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00008ed9 # 7
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x000009ff # 8
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00002f44 # 9
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x0000044e # A
    sw $t1, 0($t0)
     addi $t0, $t0, 4
    addi $t1, $zero, 0x00009899 # 1
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00003c56 # 2
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0000128d # 3
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0000dbe3 # 4
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0000d4b4 # 5
    sw $t1, 0($t0)
    addi $t0, $t0, 4  
    addi $t1, $zero, 0x00003748 # 6
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00003918 # 7
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00004112 # 8
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x0000c399 # 9
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00004955 # A
    sw $t1, 0($t0)   
    
    
    addi $t0, $zero, 0x10010000 # 0000_0000地址作为首地�?
    addi $t1, $zero, 0x003f # 0
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0006 # 1
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x005b # 2
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x004f # 3
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0066 # 4
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x006d # 5
    sw $t1, 0($t0)
    addi $t0, $t0, 4  
    addi $t1, $zero, 0x007d # 6
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x0007 # 7
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x007f # 8
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x006f # 9
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00f7 # A
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00ff # B
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00b9 # C
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00bf # D
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $zero, 0x00F9 # E
    sw $t1, 0($t0)
    addi $t0, $t0, 4 
    addi $t1, $zero, 0x00F1 # F
    sw $t1, 0($t0)
    addi $t0, $t0, 4

main:
    # ����compare_count
    # li $s7, 0
    add $s7, $zero, $zero

    # # ��a.in�ж�ȡ����
    # la $a0, input_file
    # li $a1, 0
    # li $a2, 0 
    # li $v0, 13 # ���ļ�
    # syscall

    # move $a0, $v0
    # la $a1, buffer
    # li $a2, 4004 # ��4004byte
    # li $v0, 14 # ��ȡ�ļ�
    # syscall

    # li $v0 16 # �ر��ļ�
    # syscall

    # s1�洢���������N��
    # lw $s1, buffer   
    # lw $s1, 0($zero) 
    lw $s1, 0($t0) 

    # ���� insert_sort ����
    # addi $a1, $a1, 4
    addi $a1, $t0, 4    # �������ʼ���?
    jal insert_sort

    # buffer[0] = compare_count;
    # sw $s7, buffer
    sw $s7, 0($t0)
    j display

    # # ��a.out��д����
    # la $a0, output_file
    # li $a1, 1
    # li $a2, 0
    # li $v0, 13 # ���ļ�
    # syscall

    # move $a0, $v0
    # la $a1, buffer
    # addi $a2, $s1, 1 # дN+1������
    # sll $a2, $a2, 2
    # li $v0, 15 # д���ļ�
    # syscall
    # li $v0, 16 # �ر��ļ�
    # syscall

    # # �˳�����
    # li $v0, 10
    # syscall



insert_sort:
    # insert_sortѭ���ļ������i
    addi $t9, $zero, 1
    # �ӵڶ���Ԫ�ؿ�ʼѭ��
    addi $t3, $a1, 4

out_loop_step1: # insert_sort������ѭ��
    sub $t7, $s1, $t9
    blez $t7, end_loop
    # ble $s1, $t9, end_loop
    # searchѭ���ļ������j, j=i-1
    addi $t8, $t9, -1
    # subi $t8, $t9, 1 
    # tmp = v[i]
    lw $t1, 0($t3)
    addi $t4, $t3, -4

    search_loop: # search������ѭ��
        bltz $t8, out_loop_step2 # j<0 ����ѭ��
        addi $s7, $s7, 1 # compare_count ++
        lw $t2, 0($t4)
        sub $t7, $t2, $t1
        blez $t7, out_loop_step2
        # ble $t2, $t1, out_loop_step2 # if(v[j] <= temp) break
        # ѭ�������ı�
        addi $t8, $t8, -1
        addi $t4, $t4, -4
        j search_loop # �������ѭ��??

out_loop_step2:
    addi $t5, $t8, 1 # t5=place
    addi $t6, $t4, 4 # place�ĵ�ַ
    # insertѭ���ļ������j, j=i-1
    addi $t8, $t9, -1 
    # tmp = v[i]
    lw $t1, 0($t3)
    addi $t4, $t3, -4

    insert_loop: # insert������ѭ��
        sub $t7, $t8, $t5
        bltz $t7, out_loop_step3
        # blt $t8, $t5, out_loop_step3 # j<place ����ѭ��
        lw $t2, 0($t4) # ȡ��v[j]
        sw $t2, 4($t4) # v[j+1]=v[j]
        # ѭ�������ı�
        addi $t8, $t8, -1
        addi $t4, $t4, -4
        j insert_loop # �������ѭ��??

out_loop_step3:
    sw $t1, 0($t6) # v[place]=tmp
    # ѭ�������ı�
    addi $t9, $t9, 1
    addi $t3, $t3, 4
    sub $t7, $t9, $s1
    bltz $t7, out_loop_step1
    # blt $t9, $s1, out_loop_step1 # i<N, ����ѭ��
    j end_loop

end_loop:
    jr $ra



display:
    addi $s0, $s1, 1 # ��ʾ������������+1
    # lw $s0, 64($zero) # 取出数字个数
    addi $s1, $zero, 0x10010100 # bcd7地址
    addi $t1, $zero, 60

display_loop:
    beq $s0, $zero, end_display # 结束
    addi $t1, $t1, 4 # 当前数字地址
    lw $t2, 0x10010000($t1) # 当前数字
    addi $t8, $zero, 125
    
display_inner_loop:
    sll $t3, $t2, 28 
    srl $t3, $t3, 28 # t3 = t2�?4-0�?
    sll $t3, $t3, 2 # 地址要乘4
    lw $t7, 0x10010000($t3) # 获取leds�?
    addi $t7, $t7, 0x00000100 # 显示ano0
    sw $t7, 0($s1)
    jal delay

    sll $t4, $t2, 24 
    srl $t4, $t4, 28 # t4 = t2�?7-4�?
    sll $t4, $t4, 2
    lw $t7, 0x10010000($t4)
    addi $t7, $t7, 0x00000200 # 显示ano1
    sw $t7, 0($s1)
    jal delay

    sll $t5, $t2, 20
    srl $t5, $t5, 28 # t4 = t2�?11-8�?
    sll $t5, $t5, 2
    lw $t7, 0x10010000($t5)
    addi $t7, $t7, 0x00000400 # 显示ano2
    sw $t7, 0($s1)
    jal delay

    srl $t6, $t2, 12 # t6 = t2�?15-12�? 
    sll $t6, $t6, 2
    lw $t7, 0x10010000($t6)
    addi $t7, $t7, 0x00000800 # 显示ano3
    sw $t7, 0($s1)
    jal delay
    
    addi $t8, $t8, -1
    bgtz $t8, display_inner_loop

    addi $s0, $s0, -1
    j display_loop

delay:
    addi $t0, $zero, 50000 # 50000个周�?
delay_loop:
    addi $t0, $t0, -1
    bgtz $t0, delay_loop
    jr $ra

end_display:
    sw $zero, 0($s1)
    j end_display

    
