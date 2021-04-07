---
layout: post
title: PyQt:Adding Hidden Metadata to Item in QListWidget
subtitle: Ever wanted to add extra (but hidden) data to an item in a list? Here's how!
tags: [Python, PyQt5, Tutorial]
comments: true
published: true
---
When programming, one thing is almost always important--being able to store information and retrieve it as nicely as possible, without interfering with the User Experience. That is why I wanted a way to store hidden data that I could retrieve about the selected item in a QListWidget, part of the popular __PyQt5 GUI framework__ for Python. The __QListWidget__ is a class in PyQt5 that has QtWidgets as its parent. It is a box displayed in the window, which can contain selectable items. You can name each item, and its name will appear in the list.  
The problem is, if I need to store a type of identifier in each item, how can I do that? My solution is.. creating *my own class* that inherits __QtWidgets.QListWidget__. Then, I create two methods, as seen here in my example:
{% highlight Python linenos %}
class QListWidget(QtWidgets.QListWidget):

    def __init__(self, one):
        super().__init__(one)
        self.Items = {}

    def addItemWithId(self, item, ID):
        self.Items[item] = ID
        self.addItem(item)
        
    def currentItemId(self):
        return self.Items[self.currentItem().text()]
{% endhighlight %}
### \_\_init\_\_
First, because __QtWidgets.QListWidget__ takes one positional argument, we make sure our `__init__` method has one positional argument too. I'm just calling it `one`. Then, with the `super()` function, we inherit all methods from __QtWidgets.QListWidget__, and make sure to pass the `one` argument to our `super().__init__()`. We also create a `self` variable called `Items`, which is an empty dictionary.
### addItemWithId(item, ID)
Next, our `addItemWithId` method. This method takes in two positional arguments: `item` and `ID`. First, we add a key to our `self.Items` dictionary. The key is the same as our `item` argument, and the value is our `ID` argument. Here is an example of what this does:
```python
>>> list = QListWidget(QtWidgets.QWidget(MainWindow))
>>> list.addItemWithId("Item 1", "Hidden Data")
>>> print(list.Items)
{"Item 1": "Hidden Data"}
```
As you can see, this adds the input to the dictionary.  
Then, we use the inherited `addItem` method to add our `item` argument to the list.
### currentItemId()
Finally, our `currentItemId` method. This method simply returns the value in the `Items` dictionary for the key whose name matches the current selected item in the `QListWidget`. This can be determined using `.currentItem().text()`, which is inherited from __QtWidgets.QListWidget__. Of course, we cannot simply use this method on its own, otherwise we would get

{: .box-error}
AttributeError: 'NoneType' object has no attribute 'text'

if no item is selected when it is called. So, we can create a method/function. I'll call it `get_id`. Then we can simply create an instance of our class, called `list`, then use `self.list.itemSelectionChanged.connect(self.get_id)`.  
Our `get_id` method looks like this:
```python
print(self.listWidget.currentItemId())
```
This will print the Id of the item selected, when it is selected.
You can see how this works with the code and GIF Image below:
## Testing It All
```python
self.listWidget = QListWidget(self.centralwidget)
self.listWidget.setGeometry(QtCore.QRect(190, 200, 256, 192))
self.listWidget.setObjectName("listWidget")
self.listWidget.addItemWithId("Item1", "the first")
self.listWidget.addItemWithId("Item2", 2)
self.listWidget.itemSelectionChanged.connect(self.get_id)
```
Here we create two Items with two different IDs. Then we connect `itemSelectionChanged` to our get_id method, which is the same as seen earlier above.  
![Testing Our Code](https://media.giphy.com/media/JozU5HtvYJOsCsagUN/giphy.gif){: .center-block :}  
And here, you can see that when we click the "__Item1__" button, we get "the first", and when we click "__Item2__", we get "2".

So... that's how I add extra data to my items in a __QListWidget__. I posted this because I thought this could help some people, as it seems there isn't really a way to easily do this with built in functions. If you think I could improve my code, feel free to let me know in the comments.

Edit: View the comments for a full-size GIF.
