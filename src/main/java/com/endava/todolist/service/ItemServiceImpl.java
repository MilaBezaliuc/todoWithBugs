package com.endava.todolist.service;

import com.endava.todolist.dao.ItemDAO;
import com.endava.todolist.entity.Item;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ItemServiceImpl implements ItemService {

    ItemDAO itemDAO;

    public void setItemDAO(ItemDAO itemDAO) {
        this.itemDAO = itemDAO;
    }

    @Transactional
    public void addItem(Item item) {
        this.itemDAO.addItem(item);
    }

    @Transactional
    public void editItem(Item item) {
        this.itemDAO.editItem(item);
    }

    @Transactional
    public void deleteItem(int id) {
        this.itemDAO.deleteItem(id);
    }

    @Transactional
    public Item getItemById(int id) {
        return this.itemDAO.getItemById(id);
    }

    @Transactional
    public List<Item> listItems() {
        return this.itemDAO.listItems();
    }

    @Transactional
    public List<Item> sortItems(boolean isTrue) {
        List<Item> sortedItems = new ArrayList<Item>();
        for (Item item : this.itemDAO.listItems()) {
            if (item.isDone() == isTrue) sortedItems.add(item);
        }
        return sortedItems;
    }
}
