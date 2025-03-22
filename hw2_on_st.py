import streamlit as st
import pandas as pd
import plotly.express as px
import sqlalchemy as db
import datetime



username = "sheroz2025"
password = "8888"
host = "127.0.0.1"
port = "5432"
database = "postgres"

engine = db.create_engine(f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}")


@st.cache_data
def get_invoice_data(start_date, end_date):
    query = f"""
        select invoice_date, SUM(total) AS total_sales
        from invoice
        where invoice_date between '{start_date}' and '{end_date}'
        group by invoice_date
        order by invoice_date;
    """
    return pd.read_sql(query, engine)

@st.cache_data
def get_genre_sales_data(start_date, end_date):
    query = f"""
        select g.name as genre, SUM(il.unit_price * il.quantity) as total_sales
        from invoice_line il
        inner join track t on il.track_id = t.track_id
        inner join genre g on t.genre_id = g.genre_id
        inner join invoice i on il.invoice_id = i.invoice_id
        where i.invoice_date between '{start_date}' and '{end_date}'
        group by g.name
        order by total_sales DESC;
    """
    return pd.read_sql(query, engine)


st.title("Chinook Sales Dashboard")


start_date = st.sidebar.date_input("Стартовая дата", datetime.date(2023, 1, 1))
end_date = st.sidebar.date_input("Конечная дата", datetime.date(2023, 12, 31))


invoice_data = get_invoice_data(start_date, end_date)
genre_sales_data = get_genre_sales_data(start_date, end_date)


st.subheader("Динамика продаж по датам")
fig1 = px.line(invoice_data, x="invoice_date", y="total_sales", title="Сумма продаж по датам")
st.plotly_chart(fig1)


st.subheader("Разбивка продаж по жанрам")
fig2 = px.bar(genre_sales_data, x="genre", y="total_sales", title="Сумма продаж по жанрам")
st.plotly_chart(fig2)


st.subheader(" Данные из базы")
st.write("**Инвойсы:**")
st.dataframe(invoice_data)
st.write("**Продажи по жанрам:**")
st.dataframe(genre_sales_data)

st.write("Данные обновляются при изменении периода!")
