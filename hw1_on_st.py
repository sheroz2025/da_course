import streamlit as st
import pandas as pd
import plotly.express as px
from db_connection import get_engine  


st.set_page_config(layout="wide")


st.title(" Chinook Sales Report")
st.header(" Анализ продаж")
st.subheader("Визуализация продаж по странам и месяцам")

st.markdown("Этот **дашборд** показывает  _анализ продаж_ в базе Chinook.")
st.code("""
    SELECT invoice_id, billing_country, invoice_date, total 
    FROM invoice;
""", language="sql")

st.text(" Фильтры можно выбрать в боковой панели")


engine = get_engine()


query = "SELECT invoice_id, billing_country, invoice_date, total FROM invoice;"
df = pd.read_sql(query, engine)


df["invoice_date"] = pd.to_datetime(df["invoice_date"])
df["month"] = df["invoice_date"].dt.strftime("%Y-%m")


with st.sidebar:
    st.header(" Фильтры")
    selected_countries = st.multiselect(" Выберите страны", df["billing_country"].unique(), default=df["billing_country"].unique())
    selected_years = st.multiselect("Выберите год", df["invoice_date"].dt.year.unique(), default=df["invoice_date"].dt.year.unique())


df_filtered = df[(df["billing_country"].isin(selected_countries)) & (df["invoice_date"].dt.year.isin(selected_years))]


df_grouped_countries = df_filtered.groupby("billing_country", as_index=False).agg({"total": "sum"})


df_grouped_months = df_filtered.groupby("month", as_index=False).agg({"total": "sum"})


fig1 = px.bar(
    df_grouped_countries,
    x="billing_country",
    y="total",
    title=" Сумма продаж по странам"
)


fig2 = px.line(
    df_grouped_months,
    x="month",
    y="total",
    title="Продажи по месяцам"
)


col1, col2 = st.columns(2, gap="large")

with col1:
    st.plotly_chart(fig1, use_container_width=True)

with col2:
    st.plotly_chart(fig2, use_container_width=True)

st.divider()


st.subheader("Данные после фильтрации")
st.dataframe(df_filtered)
