package com.endava.todolist.service;

import com.endava.todolist.entity.Item;

import java.util.List;

public interface ItemService {

    void addItem(Item item);

    void editItem(Item item);

    void deleteItem(int id);

    Item getItemById(int id);

    List<Item> listItems();

    List<Item> sortItems(boolean isTrue);

}
