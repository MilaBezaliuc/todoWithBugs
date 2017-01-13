package com.endava.todolist.dao;

import com.endava.todolist.entity.Item;

import java.util.List;

public interface ItemDAO {

    void addItem(Item item);

    void editItem(Item item);

    void deleteItem(int id);

    Item getItemById(int id);

    List<Item> listItems();

}
