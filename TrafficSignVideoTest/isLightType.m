%�жϱ�ʶ����Ƿ�Ϊ�źŵ�
function result=isLightType(type)
TLType={'"Բ�κ��"','"Բ���̵�"','"Բ�λƵ�"','"��ת��ͷ���"','"��ת��ͷ�̵�"','"��ת��ͷ�Ƶ�"','"ֱ�м�ͷ���"','"ֱ�м�ͷ�̵�"','"ֱ�м�ͷ�Ƶ�"','"��ת��ͷ���"','"��ת��ͷ�̵�"','"��ת��ͷ�Ƶ�"'};
result=0;

for i=1:12
    if strcmp(type,TLType(i))==1
        result=1;
        return;
    end
end
end