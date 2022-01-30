School.create! do |t|
  t.id = 1
  t.school_name = "HAL名古屋中学校"
  t.school_image_path = ""
end

Group.create! do |t|
  t.id = 1
  t.group_name = "1-1"
  t.group_grade = 1
  t.school_id = 1
end

subject_names = ["1年国語", "1年数学", "1年英語", "1年理科", "1年社会", "2年国語", "3年国語"]
subject_names.each_with_index do |subject_name, index|
  Subject.create! do |t|
    t.id = index + 1
    t.school_id = 1
    t.subject_name = subject_name
    t.subject_is_secret = false
  end
end

Subject.create! do |t|
  t.id = 8
  t.school_id = 1
  t.subject_name = "スクールカウンセラーの部屋"
  t.subject_is_secret = true
end

5.times do |i|
  GroupDirector.create! do |t|
    t.id = i + 1
    t.subject_id = i + 1
    t.group_id = 1
  end
end

GroupDirector.create! do |t|
  t.id = 6
  t.subject_id = 8
  t.group_id = 1
end

user_names = ["下村芽生", "田中智", "佐藤克", "竹内美咲", "本田智子"]
user_names.each_with_index do |user_name, index|
  User.create! do |t|
    t.email = "test#{index + 1}@example.com"
    t.user_name = user_name
    t.user_image = ''
    t.school_id = 1
    t.group_id = 1
    t.password = 'password'
    t.password_confirmation = 'password'
    t.user_is_student = true
  end
end

teacher_names = ["本郷武", "高坂美希", "加藤薫", "佐々木剛", "安藤三郎"]
teacher_names.each_with_index do |teacher_name, index|
  user = User.create! do |t|
    t.email = "test#{index + 6}@example.com"
    t.user_name = teacher_name
    t.user_image = ''
    t.school_id = 1
    t.group_id = 1
    t.password = 'password'
    t.password_confirmation = 'password'
    t.user_is_student = false
  end
end

CourseDirector.create! do |t|
  t.id = 1
  t.subject_id = 1
  t.uid = "test6@example.com"
end

2.times do |i|
  5.times do |j|
    Notification.create! do |t|
      t.id = 5 * i + j + 1
      t.uid = "test#{j + 6}@example.com"
      t.group_id = 1
      t.notification_title = "1組の数学の学期末テスト範囲について"
      t.notification_content = <<~TEXT
        2/15(火)が数学の学期末テストになります。
        以下がテスト範囲になりますが、テスト範囲以外からも、今まで習った内容を出題します。
        学期末テストは中間テストに比べ、出題範囲が広いです。
        今のうちからコツコツ勉強をしましょう。
        【教科書】
        ３章 方程式
        Ｐ.８２～P.１０３
        ４章 比例と反比例
        Ｐ.１０４～P.１０９
        【ワーク】
        P.５２～P.７３
      TEXT
    end
  end
end

7.times do |i|
  NotificationCheck.create! do |t|
    t.id = i + 1
    t.uid = "test1@example.com"
    t.notification_id = i + 1
  end
end

10.times do |i|
  Comment.create! do |t|
    t.id = i + 1
    t.subject_id = 1
    t.uid = "test1@example.com"
    t.parent_comment_id = nil
    t.comment_content = <<~TEXT
      助詞助動詞の違いが分かりません。教えてください。
    TEXT
    t.comment_is_checked = false
  end
end

comment_contents = [
  "数学のワークのp56の問2がわかりません",
  "数学ワークの56ページの問2がわかりません。教えてください。",
  "数学ワークの56ページの問2がわかりません。ヒントを教えてください。",
]
comment_contents.each_with_index do |comment_content, index|
  Comment.create! do |t|
    t.id = index + 11
    t.subject_id = 2
    t.uid = "test2@example.com"
    t.parent_comment_id = nil
    t.comment_content = comment_content
    t.comment_is_checked = false
  end
end

4.times do |i|
  Comment.create! do |t|
    t.id = i + 14
    t.subject_id = 1
    t.uid = "test7@example.com"
    t.parent_comment_id = i + 1
    t.comment_content = <<~TEXT
      違いは、いくつかありますが、大きな違いは、活用（語形変化）するかどうかです。
      例えば、打消しの助動詞「ない」は「なかろ（う）、なく、ない、なけれ（ば）」と活用（語形変化）しますが、助詞の「が」は、活用（語形変化）しません。
    TEXT
    t.comment_is_checked = true
  end
end

4.times do |i|
  Comment.create! do |t|
    t.id = i + 18
    t.subject_id = 1
    t.uid = "test7@example.com"
    t.parent_comment_id = i + 5
    t.comment_content = <<~TEXT
      違いは、いくつかありますが、大きな違いは、活用（語形変化）するかどうかです。
      例えば、打消しの助動詞「ない」は「なかろ（う）、なく、ない、なけれ（ば）」と活用（語形変化）しますが、助詞の「が」は、活用（語形変化）しません。
    TEXT
    t.comment_is_checked = false
  end
end

user_names.each_with_index do |user_name, index|
  Vote.create! do |t|
    t.id = index + 1
    t.comment_id = 11
    t.uid = "test#{index + 1}@example.com"
  end
end