a=np.array([1,2,3,4,5,6,7,8,9,10])
condlist=[a<6]      #第一个参数，必须用【】括起来，列表形式
print(condlist)
choicelist=[a+10]   #第二个参数，必须用【】括起来，列表形式
print(choicelist)
aa=np.select(condlist,choicelist,default=100)
print(aa)

[11 12 13 14 15  100  100  100  100  100]  

a=np.array([[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]])
condlist=[a<6,np.logical_and(a>10,a<16),a>20]  #参数一，定义三个限制条件
print(condlist)
choicelist=[a+10,a**2,a*10]                    #参数二，定义三个不同的操作
print(choicelist)
aa=np.select(condlist,choicelist)
print(aa)

[[ 11  12  13  14  15]                   #第一行分别加上了10
 [  0   0   0   0   0]
 [121 144 169 196 225]              #第三行每个数分别进行了平方
 [  0   0   0   0   0]
 [210 220 230 240 250]]             #第五行每个数分别乘以10


***
Choose function
***
bb=np.choose([[4,2,1,3,0],[3,4,2,0,1],[0,2,1,4,3]],[11,22,33,44,55])
print(bb)
[[55 33 22 44 11]
 [44 55 33 11 22]
 [11 33 22 55 44]]    # a 中的每一个索引 都分别与choices 对应着的。
