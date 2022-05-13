# 해시

해시 알고리즘을 언제 사용하면 좋을까?

**1. 리스트를 쓸 수 없을 때**

리스트는 숫자 인덱스를 이용하여 원소에 접근하는데 즉 list[1]은 가능하지만 list['a']는 불가능합니다. 인덱스 값을 숫자가 아닌 다른 값 '문자열, 튜플'을 사용하려고 할 때 딕셔너리를 사용하면 좋습니다.

**2. 빠른 접근  / 탐색이 필요할 때**

아래에서 표로 정리해 보여드릴 예정이지만, 딕셔너리 함수의 시간복잡도는 대부분 O(1)이므로 아주 빠른 자료구조 입니다!

****원소를 넣고 삭제하는 일이 많을 때는 Dictionary를 사용하는 것이 좋다** 

[제목 없음](https://www.notion.so/0131fda8eeb540549237c4a992693d03)

**3. 집계가 필요할 때**

원소의 개수를 세는 문제는 코딩 테스트에서 많이 출제되는 문제입니다. 이때 해시와, collections 모듈의 Counter 클래스를 사용하면 아주 빠르게 문제를 푸실 수 있을 것입니다.

## Dictionary의 item을 가져오는 법

1. key로 indexing해서 가져오기

```python
dict = {'하이': 300, '헬로': 180, 3: 5}
dict['헬로'] # 180
```

1. get을 이용해서 가져오기

```python
# get 메소드를 아용해 원소 가져오기 1
# 딕셔너리에 해당 key가 없을때 Key Error 를 내는 대신, 특정한 값을 가져온다.

dict = {'하이': 300, '헬로': 180}
dict.get('동동', 0) # 딕셔너리에 해당 키가 없으면 0을 출력하게 함 (key error를 처리)
```

## 값 집어넣기와 값 수정하기

1. 값 집어넣기

```python
# 값 집어넣기

dict = {'김철수': 300, 'Anna': 180}
dict['홍길동'] = 100
dict #{'Anna': 180, '김철수': 300, '홍길동': 100}
```

1. 값 수정하기

```python
dict = {'김철수': 300, 'Anna': 180}
dict['김철수'] += 500
dict      # 결과값: {'Anna': 180, '김철수': 800}
```

## 특정 키를 수정하기

**1. del 딕셔너리[key]**

:  해당 key를 삭제하고 끝

```python
dict = {'김철수': 300, 'Anna': 180}
del dict['김철수']
```

** 만약 key값이 존재하지 않는데 삭제하려고 하면 KeyError가 생긴다

```python
# del 이용하기 - 키가 없는 경우 raise KeyError
my_dict = {'김철수': 300, 'Anna': 180}
del my_dict['홍길동']
```

**2. 딕셔너리.pop(key, keyerror일 때 출력값)**

```python
my_dict = {'김철수': 300, 'Anna': 180}
my_dict.pop('김철수', 180)
```

- 위 코드를 실행하면 ‘김철수’의 값에 해당하는 데이터가 dictionary에서 사라지고, value가 프린트된다.
- my_dict를 조회하면 김철수의 값이 존재하지 않음

** 만약 해당 키가 존재하지 않으면 두번째 파라미터로 들어간 값을 출력한다

```python
my_dict = {'김철수': 300, 'Anna': 180}
my_dict.pop('홍길동', 180)
```

- 위 코드를 실행할 시 180이 출력되고 my_dict에서는 변경사항이 없음

## 딕셔너리 컨텐츠 조회하기

1. key만 조회하기

```python
dict = {'김철수': 300, 'Anna': 180}
for key in dict:
    print(key)
```

1. key와 value를 모두 조회하기

```python
dict = {'김철수': 300, 'Anna': 180}
for key, value in dict.items():
    print(key, value)
```

- 두 코드의 실행 속도에는 차이없음. (key불러올 때 value도 바로 부를 수 있어서 O(1)에 차이 없나봄

## 특정 key가 딕셔너리에 있는지 확인하기

```python
dict = {'김철수': 300, 'Anna': 180}
print("김철수" in dict) #True
print("김철수" not in dict) # False
```

## key와 value를 뒤집기

```python
reverse_dict= dict(map(reversed, pratice_dict.items()))
```

## 프로그래머스 테스트

해쉬 1번 문제

1. 첫번째 시도
    
    ```python
    def solution(participant, completion):
        participant = set(participant)
        completion = set(completion)
        
        answer = participant - completion
        answer = answer.pop()
        return answer
    ```
    
    3개 중 2개 케이스 통과함
    
    망한 이유 
    
    - 조건 중에 동명이인이 있을 수 있다는 조건이 있다 ( set을 이용하면 동명이인을 다른 사람으로 넣을 수가 없음 )
    
    그럼 set을 사용할 순 없음... list를 이용하면 참가자를 삭제할 때 시간이 오래 걸리게 됨. 그래서 삽입과 삭제가 빠른 dictionary를 사용함
    
    여기서 중요한 거. dictionary는 같은 key를 가질 수 없으니까 (같은 key를 추가해도 이전 key의 value가 최신화될 뿐임)  어떻게 동명인 사람이 2인 이상 있을 수 있는지 구현하는 것임
    
    key: 참가자 이름, value: 참가자 숫자   (옛날에 tf idf 구현했을 때 코드를 생각해봣음)
    
    이렇게 한 뒤에 완주자 list에서 차례차례 value - 1을 한다. 
    
    value가 0보다 큰 key가 미완주자이다. 
    
    그런데 dictionary에서는 value를 기준으로 조회할 수 없기 떄문에 value와 key의 자리를 바꿔준다. 
    
    ```python
    ## insert하고 delete해서 남은 데이터를 출력해야 하기 때문에 dictionary가 더 빠르다
    
    def solution(participant, completion):
        names = {}
        for name in participant:
            if name not in names:  ##없는 사람이 더 많을테니까 이걸 먼저
                names[name] = 1
            else:
                names[name] += 1
        for name in completion:
            names[name] -= 1
        ## key와 value의 순서를 바꾸기
        names = dict(map(reversed, names.items()))
        answer = names[1]
    
        return answer
    ```
    
     
    
    테스트케이스 통과완료